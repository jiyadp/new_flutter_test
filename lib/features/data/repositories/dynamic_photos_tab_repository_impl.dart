import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/data_sources/remote/dynamic_photos_tab_remote_data_source.dart';
import 'package:eminencetel/features/data/models/dynamic_photos_tab_model.dart';
import 'package:eminencetel/features/domain/repositories/dynamic_photos_tab_repository.dart';
import 'package:eminencetel/features/domain/usecase/dynamic_photos_tab_usecase.dart';

class DynamicPhotosTabRepositoryImpl implements DynamicPhotosTabRepository {
  final DynamicPhotosTabRemoteDataSource dynamicPhotosTabRemoteDataSource;

  DynamicPhotosTabRepositoryImpl(this.dynamicPhotosTabRemoteDataSource);

  @override
  Future<Either<Failure, DynamicPhotosTabModel>> getDynamicPhotosTabData(
      DynamicPhotosTabParams params) async {
    try {
      return Right(await dynamicPhotosTabRemoteDataSource
          .getDynamicPhotosTabData(params));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
