import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/dynamic_form_model.dart';
import 'package:eminencetel/features/domain/repositories/dynamic_form_repository.dart';
import 'package:equatable/equatable.dart';

class DynamicFormUseCase
    implements UseCase<DynamicFormModel, DynamicFormParams> {
  final DynamicFormRepository dynamicFormRepository;

  DynamicFormUseCase(this.dynamicFormRepository);

  @override
  Future<Either<Failure, DynamicFormModel>> call(DynamicFormParams params) {
    return dynamicFormRepository.getDynamicForm(params);
  }
}

class DynamicFormParams extends Equatable {
  final String formId;
  final String scheduleId;

  const DynamicFormParams({required this.formId, required this.scheduleId});

  @override
  List<Object?> get props => [formId, scheduleId];
}
