import 'package:dartz/dartz.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/domain/entities/video_project.dart';
import 'package:macro_app/domain/repositories/project_repository.dart';

class GetProjectById {
  final ProjectRepository _repository;
  const GetProjectById(this._repository);

  Future<Either<Failure, VideoProject>> call(String id) {
    return _repository.getProjectById(id);
  }
}

class UpdateProject {
  final ProjectRepository _repository;
  const UpdateProject(this._repository);

  Future<Either<Failure, VideoProject>> call({
    required String id,
    String? name,
    String? description,
    ProjectStatus? status,
  }) {
    return _repository.updateProject(
      id: id,
      name: name,
      description: description,
      status: status,
    );
  }
}

class DeleteProject {
  final ProjectRepository _repository;
  const DeleteProject(this._repository);

  Future<Either<Failure, Unit>> call(String projectId) {
    return _repository.deleteProject(projectId);
  }
}
