import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/models/schedule_details_model.dart';
import 'package:eminencetel/features/presentation/utils/task_data_model.dart';

abstract class ScheduleDetailsRepository {
  Future<Either<Failure, ScheduleDetailsModel>> getScheduleDetails(
      TaskDataModel taskDataModel);
  ScheduleDetailsData getSchedules();
  updateSchedules(ScheduleDetailsData scheduleDetailsData);
}
