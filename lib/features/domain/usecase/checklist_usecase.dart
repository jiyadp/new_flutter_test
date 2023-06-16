import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/checklist_model.dart';
import 'package:eminencetel/features/domain/repositories/checklist_repository.dart';
import 'package:equatable/equatable.dart';

class ChecklistUseCase implements UseCase<ChecklistModel, ChecklistParams> {
  final ChecklistRepository checklistRepository;

  ChecklistUseCase(this.checklistRepository);

  @override
  Future<Either<Failure, ChecklistModel>> call(ChecklistParams params) {
    return checklistRepository.getChecklist(params);
  }
}

class ChecklistParams extends Equatable {
  final String formNo;
  final String? scheduleId;

  const ChecklistParams({
    required this.formNo,
    this.scheduleId,
  });

  @override
  List<Object?> get props => [formNo,scheduleId];
}
