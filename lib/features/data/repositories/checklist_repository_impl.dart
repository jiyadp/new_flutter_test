
import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/data_sources/remote/checklist_remote_data_source.dart';
import 'package:eminencetel/features/data/models/checklist_model.dart';
import 'package:eminencetel/features/domain/repositories/checklist_repository.dart';
import 'package:eminencetel/features/domain/usecase/checklist_usecase.dart';

class ChecklistRepositoryImpl implements ChecklistRepository {
  final ChecklistRemoteDataSource checklistRemoteDataSource;

  ChecklistRepositoryImpl(this.checklistRemoteDataSource);

  @override
  Future<Either<Failure, ChecklistModel>> getChecklist(
      ChecklistParams params) async {
    try {
      return Right(await checklistRemoteDataSource.getChecklist(params));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}