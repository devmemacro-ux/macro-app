import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macro_app/domain/entities/export_settings.dart';
import 'package:macro_app/domain/usecases/video_processing/video_processing_usecases.dart';
import 'package:macro_app/presentation/providers/app_providers.dart';

enum ExportStatus { idle, preparing, exporting, complete, error }

class ExportState {
  final ExportStatus status;
  final double progress;
  final String? outputPath;
  final String? error;
  const ExportState({
    this.status = ExportStatus.idle,
    this.progress = 0.0,
    this.outputPath,
    this.error,
  });
  ExportState copyWith({
    ExportStatus? status,
    double? progress,
    String? outputPath,
    String? error,
  }) {
    return ExportState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      outputPath: outputPath ?? this.outputPath,
      error: error,
    );
  }
}

class ExportNotifier extends StateNotifier<ExportState> {
  ExportNotifier() : super(const ExportState());

  Future<void> startExport({
    required String projectId,
    required List<String> orderedClipIds,
    required ExportSettings config,
  }) async {
    if (orderedClipIds.isEmpty) {
      state = state.copyWith(status: ExportStatus.error, error: 'No clips to export');
      return;
    }

    state = state.copyWith(status: ExportStatus.preparing, progress: 0.0);

    // Resolve clip paths
    final clipPaths = orderedClipIds; // TODO: resolve actual file paths from DB

    final useCase = CombineClips(ref.read(videoProcessingRepositoryProvider));
    final result = await useCase(
      clipPaths: clipPaths,
      config: config,
      onProgress: (progress) {
        state = state.copyWith(progress: progress);
      },
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          status: ExportStatus.error,
          error: failure.message,
        );
      },
      (outputPath) {
        state = state.copyWith(
          status: ExportStatus.complete,
          outputPath: outputPath,
          progress: 1.0,
        );
      },
    );
  }

  void reset() {
    state = const ExportState();
  }
}

final exportProvider =
    StateNotifierProvider.autoDispose<ExportNotifier, ExportState>((ref) {
  return ExportNotifier();
});

// Settings provider
class SettingsState {
  final VideoResolution defaultResolution;
  final bool enableAudioByDefault;
  const SettingsState({
    this.defaultResolution = VideoResolution.hd1080,
    this.enableAudioByDefault = true,
  });
  SettingsState copyWith({
    VideoResolution? defaultResolution,
    bool? enableAudioByDefault,
  }) {
    return SettingsState(
      defaultResolution: defaultResolution ?? this.defaultResolution,
      enableAudioByDefault: enableAudioByDefault ?? this.enableAudioByDefault,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState());

  void setDefaultResolution(VideoResolution resolution) {
    state = state.copyWith(defaultResolution: resolution);
  }

  void setEnableAudio(bool enabled) {
    state = state.copyWith(enableAudioByDefault: enabled);
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
