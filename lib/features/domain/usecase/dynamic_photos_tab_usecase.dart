import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/dynamic_photos_tab_model.dart';
import 'package:eminencetel/features/domain/repositories/dynamic_photos_tab_repository.dart';
import 'package:equatable/equatable.dart';

class DynamicPhotosTabUseCase
    implements UseCase<DynamicPhotosTabModel, DynamicPhotosTabParams> {
  final DynamicPhotosTabRepository dynamicPhotosTabRepository;

  DynamicPhotosTabUseCase(this.dynamicPhotosTabRepository);

  @override
  Future<Either<Failure, DynamicPhotosTabModel>> call(
      DynamicPhotosTabParams params) {
    return dynamicPhotosTabRepository.getDynamicPhotosTabData(params);
  }
}

class DynamicPhotosTabParams extends Equatable {
  final String formId;
  final String formName;
  final String scheduleId;

  const DynamicPhotosTabParams({
    required this.formId,
    required this.formName,
    required this.scheduleId,
  });

  @override
  List<Object?> get props => [formId,formName, scheduleId];
}
