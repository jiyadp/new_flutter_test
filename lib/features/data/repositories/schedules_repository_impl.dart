import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/data_sources/local/schedules_local_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/schedules_remote_data_source.dart';
import 'package:eminencetel/features/data/models/schedules_model.dart';
import 'package:eminencetel/features/domain/repositories/schedules_repository.dart';

class SchedulesRepositoryImpl implements SchedulesRepository {
  final SchedulesRemoteDataSource schedulesRemoteDataSource;
  final SchedulesLocalDataSource schedulesLocalDataSource;

  SchedulesRepositoryImpl(this.schedulesRemoteDataSource, this.schedulesLocalDataSource);

  @override
  Future<Either<Failure, SchedulesModel>> getSchedules(String userId) async {
    try {
      var result = await schedulesRemoteDataSource.getSchedules(userId);
      // Cache task result
      if(result.data != null) {
        schedulesLocalDataSource.setSchedules(result);
      }
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  SchedulesModel getSchedulesFromCache(String userId) {
    return schedulesLocalDataSource.getSchedules();
  }
}
