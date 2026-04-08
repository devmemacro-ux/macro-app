import 'package:isar/isar.dart';
import 'package:macro_app/domain/entities/video_project.dart';

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

  ProjectStatus toDomain() {
    return ProjectStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => ProjectStatus.active,
    );
  }
}
