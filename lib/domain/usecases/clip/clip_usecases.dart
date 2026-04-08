import 'package:dartz/dartz.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/domain/entities/video_clip.dart';
import 'package:macro_app/domain/repositories/clip_repository.dart';

class AddClipToProject {
  final ClipRepository _repository;
  const AddClipToProject(this._repository);

  Future<Either<Failure, VideoClip>> call({
    required String projectId,
    required String filePath,
    required Duration duration,
    required VideoResolution resolution,
    required int frameRate,
  }) {
    return _repository.addClip(
      projectId: projectId,
      filePath: filePath,
      duration: duration,
      resolution: resolution,
      frameRate: frameRate,
    );
  }
}

class GetClipsForProject {
  final ClipRepository _repository;
  const GetClipsForProject(this._repository);

  Stream<Either<Failure, List<VideoClip>>> call(String projectId) {
    return _repository.getClipsForProject(projectId);
  }
}

class DeleteClip {
  final ClipRepository _repository;
  const DeleteClip(this._repository);

  Future<Either<Failure, Unit>> call(String clipId) {
    return _repository.deleteClip(clipId);
  }
}

class ReorderClips {
  final ClipRepository _repository;
  const ReorderClips(this._repository);

  Future<Either<Failure, Unit>> call({
    required String projectId,
    required List<String> orderedClipIds,
  }) {
    return _repository.reorderClips(
      projectId: projectId,
      orderedClipIds: orderedClipIds,
    );
  }
}

class GetClipThumbnail {
  final ClipRepository _repository;
  const GetClipThumbnail(this._repository);

  Future<Either<Failure, String>> call(String clipId) {
    return _repository.getClipThumbnail(clipId);
  }
}
