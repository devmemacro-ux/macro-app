import 'package:dartz/dartz.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/domain/entities/video_project.dart';
import 'package:macro_app/domain/repositories/project_repository.dart';

class CreateProject {
  final ProjectRepository _repository;
  const CreateProject(this._repository);

  Future<Either<Failure, VideoProject>> call({
    required String name,
    String? description,
  }) async {
    if (name.trim().isEmpty) {
      return const Left(
        ValidationFailure('Project name cannot be empty'),
      );
    }
    if (name.trim().length > 100) {
      return const Left(
        ValidationFailure(
          'Project name is too long (max 100 characters)',
        ),
      );
    }
    return await _repository.createProject(
      name: name.trim(),
      description: description,
    );
  }
}
