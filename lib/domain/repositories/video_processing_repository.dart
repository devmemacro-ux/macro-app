import 'package:dartz/dartz.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/domain/entities/export_settings.dart';

class DerivedOrientations {
  final String portraitPath;
  final String landscapePath;
  const DerivedOrientations(this.portraitPath, this.landscapePath);
}

abstract class VideoProcessingRepository {
  Future<Either<Failure, DerivedOrientations>> deriveOrientations({
    required String sourcePath,
    required String projectId,
    required String clipId,
  });

  Future<Either<Failure, String>> combineClips({
    required List<String> clipPaths,
    required ExportSettings config,
    void Function(double progress)? onProgress,
  });

  Future<bool> allSameFormat(List<String> clipPaths);
}
