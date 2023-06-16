import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/no_params.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/domain/repositories/photos_repository.dart';

class PhotosUseCase implements UseCase<PhotosModel, NoParams> {
  final PhotosRepository photosRepository;

  PhotosUseCase(this.photosRepository);

  @override
  Future<Either<Failure, PhotosModel>> call(NoParams params) {
    return photosRepository.getPhotos(params);
  }
}
