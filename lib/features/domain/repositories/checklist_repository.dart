import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/models/checklist_model.dart';
import 'package:eminencetel/features/domain/usecase/checklist_usecase.dart';

abstract class ChecklistRepository {
  Future<Either<Failure, ChecklistModel>> getChecklist(ChecklistParams params);
}
