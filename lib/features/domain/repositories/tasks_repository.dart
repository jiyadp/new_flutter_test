import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';

abstract class TasksRepository {
  Future<Either<Failure, TasksModel>> getTasks(String userId);
  Future<Either<Failure, TasksModel>> getTasksForSchedules(String scheduleId, String userId);
  TasksModel getTasksFromCache(String userId);
}
