import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/data_sources/remote/save_photography_remote_data_source.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/data/models/save_photography_model.dart';
import 'package:eminencetel/features/domain/repositories/save_photography_repository.dart';

class SavePhotographyRepositoryImpl implements SavePhotographyRepository {
  final SavePhotographyRemoteDataSource savePhotographyRemoteDataSource;

  SavePhotographyRepositoryImpl(this.savePhotographyRemoteDataSource);

  @override
  Future<Either<Failure, SavePhotographyModel>> savePhotography(
      CategoriesData params) async {
    try {
      return Right(
          await savePhotographyRemoteDataSource.savePhotography(params));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
