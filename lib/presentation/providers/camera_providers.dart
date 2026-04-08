import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macro_app/core/utils/file_helper.dart';
import 'package:macro_app/domain/entities/video_clip.dart';
import 'package:macro_app/domain/entities/video_project.dart';
import 'package:macro_app/domain/usecases/clip/clip_usecases.dart';
import 'package:macro_app/presentation/providers/app_providers.dart';
import 'package:uuid/uuid.dart';

// Clips for a specific project
final projectClipsProvider = StreamProvider.family<List<VideoClip>, String>((ref, projectId) {
  final useCase = GetClipsForProject(ref.watch(clipRepositoryProvider));
  return useCase(projectId).map(
    (either) => either.fold(
      (failure) => <VideoClip>[],
      (clips) => clips,
    ),
  );
});

// Clip use cases
final addClipProvider = Provider<AddClipToProject>((ref) {
  return AddClipToProject(ref.watch(clipRepositoryProvider));
});

final deleteClipProvider = Provider<DeleteClip>((ref) {
  return DeleteClip(ref.watch(clipRepositoryProvider));
});

final reorderClipsProvider = Provider<ReorderClips>((ref) {
  return ReorderClips(ref.watch(clipRepositoryProvider));
});

// Camera session state
enum CameraStatus { idle, previewing, recording, processing, error }

class CameraSessionState {
  final CameraStatus status;
  final Duration recordingDuration;
  final String? error;
  const CameraSessionState({
    this.status = CameraStatus.idle,
    this.recordingDuration = Duration.zero,
    this.error,
  });
  CameraSessionState copyWith({
    CameraStatus? status,
    Duration? recordingDuration,
    String? error,
  }) {
    return CameraSessionState(
      status: status ?? this.status,
      recordingDuration: recordingDuration ?? this.recordingDuration,
      error: error,
    );
  }
}

class CameraSessionNotifier extends StateNotifier<CameraSessionState> {
  CameraSessionNotifier() : super(const CameraSessionState());

  void startRecording() {
    state = state.copyWith(status: CameraStatus.recording, recordingDuration: Duration.zero);
  }

  Future<String?> stopRecording(String projectId) async {
    state = state.copyWith(status: CameraStatus.processing);

    try {
      // camerawesome returns the file path on stop
      final recordingsPath = await FileHelper.getRecordingsPath(projectId);
      final clipId = const Uuid().v4();
      final filePath = '$recordingsPath/clip_$clipId.mp4';

      // TODO: In a real implementation, get the actual recorded file path
      // from camerawesome, then trigger FFmpeg processing

      state = state.copyWith(status: CameraStatus.idle, recordingDuration: Duration.zero);
      return filePath;
    } catch (e) {
      state = state.copyWith(
        status: CameraStatus.error,
        error: e.toString(),
      );
      return null;
    }
  }

  void updateRecordingDuration(Duration duration) {
    state = state.copyWith(recordingDuration: duration);
  }
}

final cameraSessionProvider =
    StateNotifierProvider.autoDispose<CameraSessionNotifier, CameraSessionState>((ref) {
  return CameraSessionNotifier();
});
