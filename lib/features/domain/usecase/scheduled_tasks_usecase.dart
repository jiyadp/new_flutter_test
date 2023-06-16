import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/domain/repositories/tasks_repository.dart';
import 'package:equatable/equatable.dart';

class ScheduledTasksUseCase implements UseCase<TasksModel, ScheduleTaskParams> {
  final TasksRepository repository;

  ScheduledTasksUseCase(this.repository);

  @override
  Future<Either<Failure, TasksModel>> call(ScheduleTaskParams params) {
    return repository.getTasksForSchedules(params.scheduleId,params.userId);
  }
}
class ScheduleTaskParams extends Equatable {
  final String scheduleId;
  final String userId;

  const ScheduleTaskParams({
    required this.scheduleId,
    required this.userId
  });

  @override
  List<Object?> get props => [scheduleId, userId];
}
