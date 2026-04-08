import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/data/datasources/local/clip_database.dart';
import 'package:macro_app/data/models/video_clip_model.dart';
import 'package:macro_app/domain/entities/video_clip.dart';
import 'package:macro_app/domain/repositories/clip_repository.dart';

class ClipRepositoryImpl implements ClipRepository {
  final Isar _isar;
  const ClipRepositoryImpl(this._isar);

  @override
  Future<Either<Failure, VideoClip>> addClip({
    required String projectId,
    required String filePath,
    required Duration duration,
    required VideoResolution resolution,
    required int frameRate,
  }) async {
    try {
      final clip = VideoClip(
        id: const Uuid().v4(),
        projectId: projectId,
        filePath: filePath,
        portraitOutputPath: '',
        landscapeOutputPath: '',
        duration: duration,
        recordedAt: DateTime.now(),
        sourceResolution: resolution,
        frameRate: frameRate,
      );
      final model = VideoClipModel.fromDomain(clip);
      final schema = ClipSchema()
        ..uuid = model.id
        ..projectId = model.projectId
        ..filePath = model.filePath
        ..portraitOutputPath = model.portraitOutputPath
        ..landscapeOutputPath = model.landscapeOutputPath
        ..durationMs = model.durationMs
        ..recordedAt = model.recordedAt
        ..orderIndex = model.orderIndex
        ..resolution = model.resolution
        ..frameRate = model.frameRate
        ..fileSizeBytes = model.fileSizeBytes;

      await _isar.writeTxn(() async {
        await _isar.clipSchemas.put(schema);
      });

      return Right(clip);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<VideoClip>>> getClipsForProject(
    String projectId,
  ) async* {
    try {
      final clips = await _isar.clipSchemas
          .filter()
          .projectIdEqualTo(projectId)
          .sortByOrderIndex()
          .findAll();
      final domainClips = clips
          .map((s) => VideoClipModel.fromSchema(s).toDomain())
          .toList();
      yield Right(domainClips);
    } catch (e) {
      yield Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteClip(String clipId) async {
    try {
      final clip = await _isar.clipSchemas
          .filter()
          .uuidEqualTo(clipId)
          .findFirst();
      if (clip == null) {
        return const Left(DatabaseFailure('Clip not found'));
      }

      await _isar.writeTxn(() async {
        await _isar.clipSchemas.delete(clip.id);
      });

      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> reorderClips({
    required String projectId,
    required List<String> orderedClipIds,
  }) async {
    try {
      await _isar.writeTxn(() async {
        for (int i = 0; i < orderedClipIds.length; i++) {
          final clip = await _isar.clipSchemas
              .filter()
              .uuidEqualTo(orderedClipIds[i])
              .findFirst();
          if (clip != null) {
            clip.orderIndex = i;
            await _isar.clipSchemas.put(clip);
          }
        }
      });
      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getClipThumbnail(String clipId) async {
    try {
      final clip = await _isar.clipSchemas
          .filter()
          .uuidEqualTo(clipId)
          .findFirst();
      if (clip == null) {
        return const Left(DatabaseFailure('Clip not found'));
      }
      // TODO: Generate thumbnail using FFmpeg
      return Right(clip.filePath);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
