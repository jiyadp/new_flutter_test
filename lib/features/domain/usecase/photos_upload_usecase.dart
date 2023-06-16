import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/photo_upload_model.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/domain/repositories/photos_repository.dart';
import 'package:equatable/equatable.dart';

class PhotosUploadUseCase implements UseCase<PhotosUploadModel, PhotoParams> {
  final PhotosRepository photosRepository;

  PhotosUploadUseCase(this.photosRepository);

  @override
  Future<Either<Failure, PhotosUploadModel>> call(PhotoParams params) {
    return photosRepository.uploadPhotos(params);
  }
}

class PhotoParams extends Equatable {
  final File imageId;
  final CategoriesData imagesList;
  final int tabPosition;
  final int imagePosition;

  const PhotoParams(
      {required this.imageId,
      required this.imagesList,
      required this.tabPosition,
      required this.imagePosition});

  @override
  List<Object?> get props => [imageId, imagesList, tabPosition, imagePosition];
}
