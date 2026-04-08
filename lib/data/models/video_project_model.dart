import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:macro_app/data/datasources/local/project_database.dart';
import 'package:macro_app/domain/entities/video_project.dart';

part 'video_project_model.freezed.dart';
part 'video_project_model.g.dart';

@freezed
class VideoProjectModel with _$VideoProjectModel {
  const factory VideoProjectModel({
    required String id,
    required String name,
    @Default('') String description,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default('') String coverImagePath,
    @Default(0) int clipCount,
    @Default(0) int totalDurationMs,
    @Default('active') String status,
  }) = _VideoProjectModel;

  factory VideoProjectModel.fromJson(Map<String, dynamic> json) =>
      _$VideoProjectModelFromJson(json);

  factory VideoProjectModel.fromDomain(VideoProject entity) {
    return VideoProjectModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      coverImagePath: entity.coverImagePath,
      clipCount: entity.clipCount,
      totalDurationMs: entity.totalDuration.inMilliseconds,
      status: entity.status.name,
    );
  }

  factory VideoProjectModel.fromSchema(ProjectSchema schema) {
    return VideoProjectModel(
      id: schema.uuid,
      name: schema.name,
      description: schema.description ?? '',
      createdAt: schema.createdAt,
      updatedAt: schema.updatedAt,
      coverImagePath: schema.coverImagePath,
      clipCount: schema.clipCount,
      totalDurationMs: schema.totalDurationMs,
      status: schema.status,
    );
  }

  VideoProject toDomain() {
    return VideoProject(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      coverImagePath: coverImagePath,
      clipCount: clipCount,
      totalDuration: Duration(milliseconds: totalDurationMs),
      status: ProjectStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => ProjectStatus.active,
      ),
    );
  }
}
