import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/domain/repositories/tasks_repository.dart';

class TasksUseCase implements UseCase<TasksModel, String> {
  final TasksRepository repository;

  TasksUseCase(this.repository);

  @override
  Future<Either<Failure, TasksModel>> call(String userId) {
    return repository.getTasks(userId);
  }
}
