import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/data_sources/local/schedule_details_local_data_source.dart';
import 'package:eminencetel/features/domain/repositories/schedule_details_repository.dart';
import 'package:eminencetel/features/presentation/utils/task_data_model.dart';

import '../data_sources/remote/schedule_details_remote_data_source.dart';
import '../models/schedule_details_model.dart';

class ScheduleDetailsRepositoryImpl implements ScheduleDetailsRepository {
  final ScheduleDetailsRemoteDataSource remoteDataSource;
  final ScheduleDetailsLocalDataSource localDataSource;

  ScheduleDetailsRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, ScheduleDetailsModel>> getScheduleDetails(
      TaskDataModel taskDataModel) async {
    try {
      var result = await remoteDataSource.getScheduleDetails(taskDataModel);
      // Cache result schedule details
      if (result.data != null) {
        updateSchedules(result.data);
      }
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  ScheduleDetailsData getSchedules() {
    return localDataSource.getSchedules();
  }

  @override
  updateSchedules(ScheduleDetailsData? scheduleDetailsData) {
    localDataSource.setScheduleDetails(scheduleDetailsData);
  }
}
