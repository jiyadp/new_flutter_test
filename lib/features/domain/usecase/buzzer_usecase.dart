import 'package:eminencetel/core/no_params.dart';
import 'package:eminencetel/core/usecases/local_usecase.dart';
import 'package:eminencetel/features/data/models/schedule_details_model.dart';
import 'package:eminencetel/features/domain/repositories/app_repository.dart';

class BuzzerUseCase implements LocalUseCase<ScheduleDetailsData, NoParams> {
  final AppRepository repository;

  BuzzerUseCase(this.repository);

  @override
  ScheduleDetailsData invoke(NoParams params) {
    return repository.getTaskDetails();
  }

  setTaskDetails(ScheduleDetailsData schedule) {
    repository.setTaskDetails(schedule);
  }

}
