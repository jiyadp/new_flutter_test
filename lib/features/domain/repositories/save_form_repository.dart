import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/features/data/models/dynamic_form_model.dart';
import 'package:eminencetel/features/data/models/save_form_model.dart';

abstract class SaveFormRepository {
  Future<Either<Failure, SaveFormModel>> getSaveForm(DynamicFormData params);
}
