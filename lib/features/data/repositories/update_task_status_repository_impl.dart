import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/data_sources/remote/update_status_remote_data_source.dart';
import 'package:eminencetel/features/data/models/update_task_status_model.dart';
import 'package:eminencetel/features/domain/repositories/update_task_status_repository.dart';
import 'package:eminencetel/features/domain/usecase/update_task_status_usecase.dart';

class UpdateTaskStatusRepositoryImpl implements UpdateTaskStatusRepository {
  final UpdateTaskStatusRemoteDataSource remoteDataSource;

  UpdateTaskStatusRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UpdateTaskStatusModel>> getTaskStatus(
      UpdateTaskStatusParams params) async {
    try {
      return Right(await remoteDataSource.getTaskStatus(params));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
