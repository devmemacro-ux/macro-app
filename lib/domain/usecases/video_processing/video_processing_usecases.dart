import 'package:dartz/dartz.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/domain/entities/export_settings.dart';
import 'package:macro_app/domain/repositories/video_processing_repository.dart';

class DeriveOrientations {
  final VideoProcessingRepository _repository;
  const DeriveOrientations(this._repository);

  Future<Either<Failure, DerivedOrientations>> call({
    required String sourcePath,
    required String projectId,
    required String clipId,
  }) {
    return _repository.deriveOrientations(
      sourcePath: sourcePath,
      projectId: projectId,
      clipId: clipId,
    );
  }
}

class CombineClips {
  final VideoProcessingRepository _repository;
  const CombineClips(this._repository);

  Future<Either<Failure, String>> call({
    required List<String> clipPaths,
    required ExportSettings config,
    void Function(double progress)? onProgress,
  }) {
    return _repository.combineClips(
      clipPaths: clipPaths,
      config: config,
      onProgress: onProgress,
    );
  }
}

class ExportVideo {
  final VideoProcessingRepository _repository;
  const ExportVideo(this._repository);

  Future<Either<Failure, String>> call({
    required String projectId,
    required List<String> orderedClipIds,
    required ExportSettings settings,
    void Function(double progress)? onProgress,
  }) async {
    // Resolve clip paths based on ordering
    final clipPaths = orderedClipIds; // resolved in presentation layer
    return _repository.combineClips(
      clipPaths: clipPaths,
      config: settings,
      onProgress: onProgress,
    );
  }
}
