import 'package:dartz/dartz.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/domain/entities/video_clip.dart';

abstract class CameraRepository {
  Future<Either<Failure, Unit>> startRecording({
    required VideoResolution quality,
    @Default(true) bool enableAudio,
  });

  Future<Either<Failure, VideoClip>> stopRecording({
    required String projectId,
  });

  Future<Either<Failure, Unit>> switchCamera();

  Future<Either<Failure, Unit>> setFlashMode(FlashMode mode);

  Future<Either<Failure, Unit>> setZoomLevel(double level);
}
