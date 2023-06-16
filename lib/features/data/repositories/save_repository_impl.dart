import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/data_sources/local/local_fiber_hope_data_source.dart';
import 'package:eminencetel/features/data/data_sources/remote/save_remote_data_source.dart';
import 'package:eminencetel/features/data/models/fiber_hope_model.dart';
import 'package:eminencetel/features/data/models/save_model.dart';
import 'package:eminencetel/features/domain/repositories/save_repository.dart';

class SaveRepositoryImpl implements SaveRepository {
  final SaveRemoteDataSource saveRemoteDataSource;
  final LocalFiberHopeDataSource localFiberHopeDataSource;

  SaveRepositoryImpl(this.saveRemoteDataSource, this.localFiberHopeDataSource);

  @override
  Future<Either<Failure, SaveModel>> save(FiberHopeModel params) async {
    try {
      var result = await saveRemoteDataSource.save(params);
      if (result.data?.isNotEmpty == true) {
        localFiberHopeDataSource.setFiberHopeData(FiberHopeModel());
      }
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SaveModel>> update(FiberHopeModel params) async {
    try {
      var result = await saveRemoteDataSource.update(params);
      if (result.data?.isNotEmpty == true) {
        localFiberHopeDataSource.setFiberHopeData(FiberHopeModel());
      }
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
