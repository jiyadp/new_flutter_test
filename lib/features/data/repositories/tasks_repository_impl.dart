import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/data_sources/local/tasks_local_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/tasks_remote_data_source.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/domain/repositories/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksRemoteDataSource taskRemoteDataSource;
  final TasksLocalDataSource localDataSource;

  TasksRepositoryImpl(this.taskRemoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, TasksModel>> getTasks(String userId) async {
    try {
      var result = await taskRemoteDataSource.getTasks(userId);
      // Cache task result
      if(result.data != null) {
        localDataSource.setTasks(result);
      }
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  TasksModel getTasksFromCache(String userId) {
    return localDataSource.getTasks();
  }

  @override
  Future<Either<Failure, TasksModel>> getTasksForSchedules(String scheduleId, String userId) async {
    try {
      var result = await taskRemoteDataSource.getTasksForSchedules(scheduleId,userId);
      // Cache task result
      // if(result.data != null) {
      //   localDataSource.setTasks(result);
      // }
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
