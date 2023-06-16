import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/schedules_model.dart';
import 'package:eminencetel/features/domain/repositories/schedules_repository.dart';

class SchedulesUseCase implements UseCase<SchedulesModel, String> {
  final SchedulesRepository repository;

  SchedulesUseCase(this.repository);

  @override
  Future<Either<Failure, SchedulesModel>> call(String userId) {
    return repository.getSchedules(userId);
  }
}
