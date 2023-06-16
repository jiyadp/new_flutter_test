import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/update_task_status_model.dart';
import 'package:eminencetel/features/domain/repositories/update_task_status_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateTaskStatusUseCase
    implements UseCase<UpdateTaskStatusModel, UpdateTaskStatusParams> {
  final UpdateTaskStatusRepository repository;

  UpdateTaskStatusUseCase(this.repository);

  @override
  Future<Either<Failure, UpdateTaskStatusModel>> call(
      UpdateTaskStatusParams params) {
    return repository.getTaskStatus(params);
  }
}

class UpdateTaskStatusParams extends Equatable {
  final String scheduleId;
  final String taskNo;
  final String taskStatus;
  final String comments;

  const UpdateTaskStatusParams({
    required this.scheduleId,
    required this.taskNo,
    required this.taskStatus,
    required this.comments,
  });

  @override
  List<Object?> get props => [scheduleId, taskNo, taskStatus, comments];
}
