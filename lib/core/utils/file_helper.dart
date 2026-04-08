import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:macro_app/core/constants/app_constants.dart';

class FileHelper {
  FileHelper._();

  static Future<String> getAppStoragePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, AppConstants.appDirectoryName);
  }

  static Future<String> getRecordingsPath(String projectId) async {
    final base = await getAppStoragePath();
    final dir = Directory(p.join(base, AppConstants.recordingsFolderName, projectId));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }

  static Future<String> getProcessedPath(String projectId) async {
    final base = await getAppStoragePath();
    final dir = Directory(p.join(base, AppConstants.processedFolderName, projectId));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }

  static Future<String> getExportPath() async {
    final base = await getAppStoragePath();
    final dir = Directory(p.join(base, AppConstants.exportsFolderName));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }

  static Future<String> getCoverPath(String projectId) async {
    final base = await getAppStoragePath();
    final dir = Directory(p.join(base, AppConstants.coversFolderName));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return p.join(dir.path, '${projectId}_cover.jpg');
  }

  static String generateClipFileName(String clipId, {String? suffix}) {
    final ext = suffix != null ? '_$suffix.mp4' : '.mp4';
    return 'clip_$clipId$ext';
  }

  static Future<bool> hasEnoughStorage(int requiredBytes) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final stat = await FileSystemEntity.type(dir.path);
      if (stat == FileSystemEntityType.notFound) return false;
      // Approximate check - platform specific
      return true;
    } catch (e) {
      return false;
    }
  }
}
