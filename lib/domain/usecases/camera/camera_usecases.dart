import 'package:dartz/dartz.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/domain/entities/video_clip.dart';
import 'package:macro_app/domain/repositories/camera_repository.dart';

class StartRecording {
  final CameraRepository _repository;
  const StartRecording(this._repository);

  Future<Either<Failure, RecordingSession>> call({
    required VideoResolution quality,
    required bool enableAudio,
  }) {
    return _repository.startRecording(
      quality: quality,
      enableAudio: enableAudio,
    );
  }
}

class StopRecording {
  final CameraRepository _repository;
  const StopRecording(this._repository);

  Future<Either<Failure, VideoClip>> call({
    required String projectId,
  }) {
    return _repository.stopRecording(projectId: projectId);
  }
}

class SwitchCamera {
  final CameraRepository _repository;
  const SwitchCamera(this._repository);

  Future<Either<Failure, Unit>> call() {
    return _repository.switchCamera();
  }
}

class ToggleFlash {
  final CameraRepository _repository;
  const ToggleFlash(this._repository);

  Future<Either<Failure, Unit>> call(FlashMode mode) {
    return _repository.setFlashMode(mode);
  }
}
