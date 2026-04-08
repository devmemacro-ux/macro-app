import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_project.freezed.dart';

@freezed
class VideoProject with _$VideoProject {
  const factory VideoProject({
    required String id,
    required String name,
    @Default('') String description,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default('') String coverImagePath,
    @Default(0) int clipCount,
    @Default(Duration.zero) Duration totalDuration,
    @Default(ProjectStatus.active) ProjectStatus status,
  }) = _VideoProject;
}

enum ProjectStatus {
  active,
  archived,
  exported,
}
