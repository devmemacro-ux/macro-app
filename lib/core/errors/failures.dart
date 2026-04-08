import 'package:equatable/equatable.dart';

/// Base failure class for all error cases in the domain layer.
abstract class Failure extends Equatable {
  final String message;
  final String? stackTrace;

  const Failure(this.message, [this.stackTrace]);

  @override
  List<Object?> get props => [message, stackTrace];
}

class CameraFailure extends Failure {
  const CameraFailure(super.message, [super.stackTrace]);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, [super.stackTrace]);
}

class FileFailure extends Failure {
  const FileFailure(super.message, [super.stackTrace]);
}

class VideoProcessingFailure extends Failure {
  const VideoProcessingFailure(super.message, [super.stackTrace]);
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message, [super.stackTrace]);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, [super.stackTrace]);
}
