import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:macro_app/data/datasources/local/clip_database.dart';
import 'package:macro_app/domain/entities/video_clip.dart';

part 'video_clip_model.freezed.dart';
part 'video_clip_model.g.dart';

@freezed
class VideoClipModel with _$VideoClipModel {
  const factory VideoClipModel({
    required String id,
    required String projectId,
    required String filePath,
    @Default('') String portraitOutputPath,
    @Default('') String landscapeOutputPath,
    required int durationMs,
    required DateTime recordedAt,
    @Default(0) int orderIndex,
    @Default('hd1080') String resolution,
    @Default(30) int frameRate,
    @Default(0) int fileSizeBytes,
  }) = _VideoClipModel;

  factory VideoClipModel.fromJson(Map<String, dynamic> json) =>
      _$VideoClipModelFromJson(json);

  factory VideoClipModel.fromDomain(VideoClip entity) {
    return VideoClipModel(
      id: entity.id,
      projectId: entity.projectId,
      filePath: entity.filePath,
      portraitOutputPath: entity.portraitOutputPath,
      landscapeOutputPath: entity.landscapeOutputPath,
      durationMs: entity.duration.inMilliseconds,
      recordedAt: entity.recordedAt,
      orderIndex: entity.orderIndex,
      resolution: entity.sourceResolution.name,
      frameRate: entity.frameRate,
      fileSizeBytes: entity.fileSizeBytes,
    );
  }

  factory VideoClipModel.fromSchema(ClipSchema schema) {
    return VideoClipModel(
      id: schema.uuid,
      projectId: schema.projectId,
      filePath: schema.filePath,
      portraitOutputPath: schema.portraitOutputPath,
      landscapeOutputPath: schema.landscapeOutputPath,
      durationMs: schema.durationMs,
      recordedAt: schema.recordedAt,
      orderIndex: schema.orderIndex,
      resolution: schema.resolution,
      frameRate: schema.frameRate,
      fileSizeBytes: schema.fileSizeBytes,
    );
  }

  VideoClip toDomain() {
    return VideoClip(
      id: id,
      projectId: projectId,
      filePath: filePath,
      portraitOutputPath: portraitOutputPath,
      landscapeOutputPath: landscapeOutputPath,
      duration: Duration(milliseconds: durationMs),
      recordedAt: recordedAt,
      orderIndex: orderIndex,
      sourceResolution: VideoResolution.values.firstWhere(
        (e) => e.name == resolution,
        orElse: () => VideoResolution.hd1080,
      ),
      frameRate: frameRate,
      fileSizeBytes: fileSizeBytes,
    );
  }
}
