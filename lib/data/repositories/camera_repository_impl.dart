import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:dartz/dartz.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/domain/entities/video_clip.dart';
import 'package:macro_app/domain/repositories/camera_repository.dart';

class CameraRepositoryImpl implements CameraRepository {
  CameraAwesomePlugin get _camera => CameraAwesomePlugin();

  @override
  Future<Either<Failure, Unit>> startRecording({
    required VideoResolution quality,
    required bool enableAudio,
  }) async {
    try {
      await CameraAwesomePlugin.startVideoRecording(
        enableAudio: enableAudio,
        // TODO: Map VideoResolution to SensorConfig
      );
      return const Right(null); // camerawesome handles session internally
    } catch (e) {
      return Left(CameraFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VideoClip>> stopRecording({
    required String projectId,
  }) async {
    try {
      final path = await CameraAwesomePlugin.stopVideoRecording();
      // VideoClip is created after FFmpeg processing in the use case layer
      return Left(const CameraFailure(
        'Stop recording — clip is created after FFmpeg processing',
      ));
    } catch (e) {
      return Left(CameraFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> switchCamera() async {
    try {
      await CameraAwesomePlugin.switchCameraSensor();
      return const Right(unit);
    } catch (e) {
      return Left(CameraFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> setFlashMode(FlashMode mode) async {
    try {
      await CameraAwesomePlugin.setFlashMode(mode);
      return const Right(unit);
    } catch (e) {
      return Left(CameraFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> setZoomLevel(double level) async {
    try {
      await CameraAwesomePlugin.setZoom(level);
      return const Right(unit);
    } catch (e) {
      return Left(CameraFailure(e.toString()));
    }
  }
}
