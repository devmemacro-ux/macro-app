import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/core/utils/file_helper.dart';
import 'package:macro_app/domain/entities/export_settings.dart';
import 'package:macro_app/domain/repositories/video_processing_repository.dart';

class VideoProcessingRepositoryImpl implements VideoProcessingRepository {
  @override
  Future<Either<Failure, DerivedOrientations>> deriveOrientations({
    required String sourcePath,
    required String projectId,
    required String clipId,
  }) async {
    try {
      final processedDir = await FileHelper.getProcessedPath(projectId);
      final portraitPath = '$processedDir/clip_${clipId}_portrait.mp4';
      final landscapePath = '$processedDir/clip_${clipId}_landscape.mp4';

      // Portrait: center crop to 9:16
      final portraitCmd =
          '-i $sourcePath -vf "crop=ih*(9/16):ih:(iw-ih*(9/16))/2:0" '
          '-c:v libx264 -preset medium -crf 18 -c:a aac -b:a 128k '
          '-movflags +faststart "$portraitPath"';

      final portraitSession = await FFmpegKit.execute(portraitCmd);
      final portraitRc = await portraitSession.getReturnCode();
      if (!ReturnCode.isSuccess(portraitRc)) {
        final logs = await portraitSession.getLogsAsString();
        return Left(VideoProcessingFailure('Portrait crop failed: $logs'));
      }

      // Landscape: stream copy (no re-encode)
      final landscapeCmd =
          '-i $sourcePath -c copy -movflags +faststart "$landscapePath"';
      final landscapeSession = await FFmpegKit.execute(landscapeCmd);
      final landscapeRc = await landscapeSession.getReturnCode();
      if (!ReturnCode.isSuccess(landscapeRc)) {
        final logs = await landscapeSession.getLogsAsString();
        return Left(VideoProcessingFailure('Landscape copy failed: $logs'));
      }

      return Right(DerivedOrientations(portraitPath, landscapePath));
    } catch (e) {
      return Left(VideoProcessingFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> combineClips({
    required List<String> clipPaths,
    required ExportSettings config,
    void Function(double progress)? onProgress,
  }) async {
    try {
      if (clipPaths.isEmpty) {
        return const Left(VideoProcessingFailure('No clips to combine'));
      }

      if (clipPaths.length == 1) {
        final output = '${config.outputPath}/export_${DateTime.now().millisecondsSinceEpoch}.mp4';
        await File(clipPaths.first).copy(output);
        return Right(output);
      }

      // Create concat list file
      final listPath = '/tmp/concat_list_${DateTime.now().millisecondsSinceEpoch}.txt';
      final listFile = File(listPath);
      final content = clipPaths.map((p) => "file '$p'").join('\n');
      await listFile.writeAsString(content);

      final output = '${config.outputPath}/export_${DateTime.now().millisecondsSinceEpoch}.mp4';

      // Use concat demuxer for same-format clips
      final cmd = '-f concat -safe 0 -i $listPath -c copy "$output"';
      final session = await FFmpegKit.execute(cmd);
      final rc = await session.getReturnCode();

      await listFile.delete();

      if (!ReturnCode.isSuccess(rc)) {
        final logs = await session.getLogsAsString();
        return Left(VideoProcessingFailure('Concat failed: $logs'));
      }

      return Right(output);
    } catch (e) {
      return Left(VideoProcessingFailure(e.toString()));
    }
  }

  @override
  Future<bool> allSameFormat(List<String> clipPaths) async {
    // TODO: Check actual codec/format info from each clip
    return true;
  }
}
