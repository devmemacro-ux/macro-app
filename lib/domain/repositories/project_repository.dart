import 'package:dartz/dartz.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/domain/entities/video_project.dart';

abstract class ProjectRepository {
  Future<Either<Failure, VideoProject>> createProject({
    required String name,
    String? description,
  });

  Stream<Either<Failure, List<VideoProject>>> getAllProjects();

  Future<Either<Failure, VideoProject>> getProjectById(String id);

  Future<Either<Failure, VideoProject>> updateProject({
    required String id,
    String? name,
    String? description,
    ProjectStatus? status,
  });

  Future<Either<Failure, Unit>> deleteProject(String projectId);
}
