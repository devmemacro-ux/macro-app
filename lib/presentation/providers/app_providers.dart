import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:macro_app/core/di/injection.dart';
import 'package:macro_app/data/repositories/clip_repository_impl.dart';
import 'package:macro_app/data/repositories/camera_repository_impl.dart';
import 'package:macro_app/data/repositories/project_repository_impl.dart';
import 'package:macro_app/data/repositories/video_processing_repository_impl.dart';
import 'package:macro_app/domain/repositories/clip_repository.dart';
import 'package:macro_app/domain/repositories/camera_repository.dart';
import 'package:macro_app/domain/repositories/project_repository.dart';
import 'package:macro_app/domain/repositories/video_processing_repository.dart';

// Repository providers
final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  final isar = ref.watch(databaseProvider);
  return ProjectRepositoryImpl(isar);
});

final clipRepositoryProvider = Provider<ClipRepository>((ref) {
  final isar = ref.watch(databaseProvider);
  return ClipRepositoryImpl(isar);
});

final cameraRepositoryProvider = Provider<CameraRepository>((ref) {
  return CameraRepositoryImpl();
});

final videoProcessingRepositoryProvider =
    Provider<VideoProcessingRepository>((ref) {
  return VideoProcessingRepositoryImpl();
});

// App state
class AppState {
  final bool isFirstLaunch;
  final bool isDarkMode;
  const AppState({this.isFirstLaunch = true, this.isDarkMode = true});
  AppState copyWith({bool? isFirstLaunch, bool? isDarkMode}) {
    return AppState(
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState());

  void setFirstLaunchComplete() {
    state = state.copyWith(isFirstLaunch: false);
  }
}

final appStateProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});
