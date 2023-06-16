import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/dynamic_form_model.dart';
import 'package:eminencetel/features/data/models/save_form_model.dart';
import 'package:eminencetel/features/domain/repositories/save_form_repository.dart';

class SaveFormUseCase implements UseCase<SaveFormModel, DynamicFormData> {
  final SaveFormRepository saveFormRepository;

  SaveFormUseCase(this.saveFormRepository);

  @override
  Future<Either<Failure, SaveFormModel>> call(DynamicFormData params) {
    return saveFormRepository.getSaveForm(params);
  }
}
