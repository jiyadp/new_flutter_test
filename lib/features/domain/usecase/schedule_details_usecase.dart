import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/no_params.dart';
import 'package:eminencetel/core/usecases/local_usecase.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/schedule_details_model.dart';
import 'package:eminencetel/features/domain/repositories/schedule_details_repository.dart';
import 'package:eminencetel/features/presentation/utils/task_data_model.dart';

class ScheduleDetailsUseCase
    implements
        UseCase<ScheduleDetailsModel, TaskDataModel>,
        LocalUseCase<ScheduleDetailsModel, NoParams> {
  final ScheduleDetailsRepository repository;

  ScheduleDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, ScheduleDetailsModel>> call(
      TaskDataModel taskDataModel) {
    return repository.getScheduleDetails(taskDataModel);
  }

  @override
  ScheduleDetailsModel invoke(NoParams params) {
    throw UnimplementedError();
  }
}
