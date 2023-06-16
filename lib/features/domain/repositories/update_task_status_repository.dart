import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/models/update_task_status_model.dart';
import 'package:eminencetel/features/domain/usecase/update_task_status_usecase.dart';

abstract class UpdateTaskStatusRepository {
  Future<Either<Failure, UpdateTaskStatusModel>> getTaskStatus(
      UpdateTaskStatusParams params);
}
