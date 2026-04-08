import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macro_app/domain/entities/video_project.dart';
import 'package:macro_app/domain/usecases/project/create_project.dart';
import 'package:macro_app/domain/usecases/project/get_all_projects.dart';
import 'package:macro_app/domain/usecases/project/project_usecases.dart';
import 'package:macro_app/presentation/providers/app_providers.dart';

final createProjectProvider = Provider<CreateProject>((ref) {
  return CreateProject(ref.watch(projectRepositoryProvider));
});

final getAllProjectsProvider = Provider<GetAllProjects>((ref) {
  return GetAllProjects(ref.watch(projectRepositoryProvider));
});

final getProjectByIdProvider = Provider<GetProjectById>((ref) {
  return GetProjectById(ref.watch(projectRepositoryProvider));
});

final deleteProjectProvider = Provider<DeleteProject>((ref) {
  return DeleteProject(ref.watch(projectRepositoryProvider));
});

final updateProjectProvider = Provider<UpdateProject>((ref) {
  return UpdateProject(ref.watch(projectRepositoryProvider));
});

// Stream of all projects
final allProjectsStreamProvider = StreamProvider<List<VideoProject>>((ref) {
  final useCase = ref.watch(getAllProjectsProvider);
  return useCase().map(
    (either) => either.fold(
      (failure) => <VideoProject>[],
      (projects) => projects,
    ),
  );
});

// Current project being viewed
final currentProjectIdProvider = StateProvider<String?>((ref) => null);

// Create project form
class CreateProjectFormState {
  final String name;
  final String description;
  final bool isLoading;
  final String? error;
  const CreateProjectFormState({
    this.name = '',
    this.description = '',
    this.isLoading = false,
    this.error,
  });
  CreateProjectFormState copyWith({
    String? name,
    String? description,
    bool? isLoading,
    String? error,
  }) {
    return CreateProjectFormState(
      name: name ?? this.name,
      description: description ?? this.description,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CreateProjectFormNotifier extends StateNotifier<CreateProjectFormState> {
  CreateProjectFormNotifier(this._useCase) : super(const CreateProjectFormState());
  final CreateProject _useCase;

  void setName(String name) {
    state = state.copyWith(name: name, error: null);
  }

  void setDescription(String desc) {
    state = state.copyWith(description: desc);
  }

  Future<bool> submit() async {
    if (state.name.trim().isEmpty) {
      state = state.copyWith(error: 'Please enter a project name');
      return false;
    }
    state = state.copyWith(isLoading: true, error: null);

    final result = await _useCase(
      name: state.name,
      description: state.description,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
    );
  }
}

final createProjectFormProvider =
    StateNotifierProvider.autoDispose<CreateProjectFormNotifier,
        CreateProjectFormState>((ref) {
  return CreateProjectFormNotifier(
    ref.watch(createProjectProvider),
  );
});
