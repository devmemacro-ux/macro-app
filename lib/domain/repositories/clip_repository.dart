import 'package:dartz/dartz.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/domain/entities/video_clip.dart';

abstract class ClipRepository {
  Future<Either<Failure, VideoClip>> addClip({
    required String projectId,
    required String filePath,
    required Duration duration,
    required VideoResolution resolution,
    required int frameRate,
  });

  Stream<Either<Failure, List<VideoClip>>> getClipsForProject(String projectId);

  Future<Either<Failure, Unit>> deleteClip(String clipId);

  Future<Either<Failure, Unit>> reorderClips({
    required String projectId,
    required List<String> orderedClipIds,
  });

  Future<Either<Failure, String>> getClipThumbnail(String clipId);
}
