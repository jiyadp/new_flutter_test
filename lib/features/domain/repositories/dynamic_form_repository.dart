import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/models/dynamic_form_model.dart';
import 'package:eminencetel/features/domain/usecase/dynamic_form_usecase.dart';

abstract class DynamicFormRepository {
  Future<Either<Failure, DynamicFormModel>> getDynamicForm(
      DynamicFormParams params);
}
