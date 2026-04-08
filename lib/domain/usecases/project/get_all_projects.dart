import 'package:dartz/dartz.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/domain/entities/video_project.dart';
import 'package:macro_app/domain/repositories/project_repository.dart';

class GetAllProjects {
  final ProjectRepository _repository;
  const GetAllProjects(this._repository);

  Stream<Either<Failure, List<VideoProject>>> call() {
    return _repository.getAllProjects();
  }
}
