import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:macro_app/core/utils/video_orientation.dart';

part 'clip_sequence.freezed.dart';

@freezed
class ClipSequence with _$ClipSequence {
  const factory ClipSequence({
    required String id,
    required String projectId,
    required List<SequenceClip> clips,
    required DateTime createdAt,
  }) = _ClipSequence;
}

@freezed
class SequenceClip with _$SequenceClip {
  const factory SequenceClip({
    required String clipId,
    required int sequenceOrder,
    @Default(VideoOrientation.original) VideoOrientation orientation,
    @Default(Duration.zero) Duration trimStart,
    Duration? trimEnd,
  }) = _SequenceClip;
}
