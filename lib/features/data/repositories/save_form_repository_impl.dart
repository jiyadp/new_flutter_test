import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/data_sources/remote/save_form_remote_data_source.dart';
import 'package:eminencetel/features/data/models/dynamic_form_model.dart';
import 'package:eminencetel/features/data/models/save_form_model.dart';
import 'package:eminencetel/features/domain/repositories/save_form_repository.dart';

class SaveFormRepositoryImpl implements SaveFormRepository {
  final SaveFormRemoteDataSource saveFormRemoteDataSource;

  SaveFormRepositoryImpl(this.saveFormRemoteDataSource);

  @override
  Future<Either<Failure, SaveFormModel>> getSaveForm(
      DynamicFormData params) async {
    try {
      return Right(await saveFormRemoteDataSource.getSaveForm(params));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
