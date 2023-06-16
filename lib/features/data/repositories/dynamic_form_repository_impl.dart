import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/data_sources/remote/dynamic_form_remote_data_source.dart';
import 'package:eminencetel/features/data/models/dynamic_form_model.dart';
import 'package:eminencetel/features/domain/repositories/dynamic_form_repository.dart';
import 'package:eminencetel/features/domain/usecase/dynamic_form_usecase.dart';

class DynamicFormRepositoryImpl implements DynamicFormRepository {
  final DynamicFormRemoteDataSource dynamicFormRemoteDataSource;

  DynamicFormRepositoryImpl(this.dynamicFormRemoteDataSource);

  @override
  Future<Either<Failure, DynamicFormModel>> getDynamicForm(
      DynamicFormParams params) async {
    try {
      return Right(await dynamicFormRemoteDataSource.getDynamicForm(params));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
