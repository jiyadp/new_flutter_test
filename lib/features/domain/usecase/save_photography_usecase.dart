import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/data/models/save_photography_model.dart';
import 'package:eminencetel/features/domain/repositories/save_photography_repository.dart';

class SavePhotographyUseCase
    implements UseCase<SavePhotographyModel, CategoriesData> {
  final SavePhotographyRepository savePhotographyRepository;

  SavePhotographyUseCase(this.savePhotographyRepository);

  @override
  Future<Either<Failure, SavePhotographyModel>> call(CategoriesData params) {
    return savePhotographyRepository.savePhotography(params);
  }
}
