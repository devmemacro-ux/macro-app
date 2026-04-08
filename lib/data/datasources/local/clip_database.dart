import 'package:isar/isar.dart';
import 'package:macro_app/domain/entities/video_clip.dart';

part 'clip_database.g.dart';

@collection
class ClipSchema {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index()
  late String projectId;

  late String filePath;

  late String portraitOutputPath;

  late String landscapeOutputPath;

  late int durationMs;

  late DateTime recordedAt;

  int orderIndex = 0;

  late String resolution;

  int frameRate = 30;

  int fileSizeBytes = 0;
}
