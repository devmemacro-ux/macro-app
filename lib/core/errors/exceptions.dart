class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Cache error occurred']);
}

class DatabaseException implements Exception {
  final String message;
  const DatabaseException([this.message = 'Database error occurred']);
}

class FileException implements Exception {
  final String message;
  const FileException([this.message = 'File error occurred']);
}

class CameraException implements Exception {
  final String message;
  const CameraException([this.message = 'Camera error occurred']);
}

class VideoProcessingException implements Exception {
  final String message;
  const VideoProcessingException({this.message = 'Video error'});
}
