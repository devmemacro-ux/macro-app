import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_clip.freezed.dart';

@freezed
class VideoClip with _$VideoClip {
  const factory VideoClip({
    required String id,
    required String projectId,
    required String filePath,
    required String portraitOutputPath,
    required String landscapeOutputPath,
    required Duration duration,
    required DateTime recordedAt,
    @Default(0) int orderIndex,
    @Default(VideoResolution.hd1080) VideoResolution sourceResolution,
    @Default(30) int frameRate,
    @Default(0) int fileSizeBytes,
  }) = _VideoClip;
}

enum VideoResolution {
  hd720,
  hd1080,
  qhd1440,
  uhd4k,
}
