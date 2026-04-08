import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:macro_app/core/errors/exceptions.dart';
import 'package:macro_app/core/errors/failures.dart';
import 'package:macro_app/data/datasources/local/project_database.dart';
import 'package:macro_app/data/models/video_project_model.dart';
import 'package:macro_app/domain/entities/video_project.dart';
import 'package:macro_app/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Isar _isar;
  const ProjectRepositoryImpl(this._isar);

  @override
  Future<Either<Failure, VideoProject>> createProject({
    required String name,
    String? description,
  }) async {
    try {
      final now = DateTime.now();
      final project = VideoProject(
        id: const Uuid().v4(),
        name: name,
        description: description ?? '',
        createdAt: now,
        updatedAt: now,
      );
      final model = VideoProjectModel.fromDomain(project);
      final schema = ProjectSchema()
        ..uuid = model.id
        ..name = model.name
        ..description = model.description.isEmpty ? null : model.description
        ..createdAt = model.createdAt
        ..updatedAt = model.updatedAt
        ..coverImagePath = model.coverImagePath
        ..clipCount = model.clipCount
        ..totalDurationMs = model.totalDurationMs
        ..status = model.status;

      await _isar.writeTxn(() async {
        await _isar.projectSchemas.put(schema);
      });

      return Right(project);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<VideoProject>>> getAllProjects() async* {
    try {
      final projects = await _isar.projectSchemas.where().findAll();
      final domainProjects = projects
          .map((s) => VideoProjectModel.fromSchema(s).toDomain())
          .toList()
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      yield Right(domainProjects);
    } catch (e) {
      yield Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VideoProject>> getProjectById(String id) async {
    try {
      final project =
          await _isar.projectSchemas.filter().uuidEqualTo(id).findFirst();
      if (project == null) {
        return const Left(DatabaseFailure('Project not found'));
      }
      return Right(VideoProjectModel.fromSchema(project).toDomain());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VideoProject>> updateProject({
    required String id,
    String? name,
    String? description,
    ProjectStatus? status,
  }) async {
    try {
      final existing =
          await _isar.projectSchemas.filter().uuidEqualTo(id).findFirst();
      if (existing == null) {
        return const Left(DatabaseFailure('Project not found'));
      }

      if (name != null) existing.name = name;
      if (description != null) existing.description = description;
      if (status != null) existing.status = status.name;
      existing.updatedAt = DateTime.now();

      await _isar.writeTxn(() async {
        await _isar.projectSchemas.put(existing);
      });

      return Right(VideoProjectModel.fromSchema(existing).toDomain());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProject(String projectId) async {
    try {
      final existing =
          await _isar.projectSchemas.filter().uuidEqualTo(projectId).findFirst();
      if (existing == null) {
        return const Left(DatabaseFailure('Project not found'));
      }

      await _isar.writeTxn(() async {
        await _isar.projectSchemas.delete(existing.id);
      });

      return const Right(unit);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
