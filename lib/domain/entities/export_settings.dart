import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:macro_app/domain/entities/video_clip.dart';

part 'export_settings.freezed.dart';

@freezed
class ExportSettings with _$ExportSettings {
  const factory ExportSettings({
    @Default('mp4') String outputFormat,
    @Default(VideoResolution.hd1080) VideoResolution outputResolution,
    @Default(30) int frameRate,
    @Default(10) int bitrateMbps,
    @Default('') String outputPath,
    @Default(true) bool includeAudio,
  }) = _ExportSettings;
}
