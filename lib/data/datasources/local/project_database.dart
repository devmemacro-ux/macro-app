import 'package:isar/isar.dart';

part 'project_database.g.dart';

@collection
class ProjectSchema {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  late String name;

  String? description;

  late DateTime createdAt;

  late DateTime updatedAt;

  late String coverImagePath;

  int clipCount = 0;

  int totalDurationMs = 0;

  late String status;
}
