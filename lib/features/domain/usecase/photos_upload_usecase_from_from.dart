import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/usecases/usecase.dart';
import 'package:eminencetel/features/data/models/photo_upload_model.dart';
import 'package:eminencetel/features/domain/repositories/photos_repository.dart';

class PhotosUploadUseCaseFromForm implements UseCase<PhotosUploadModel, File> {
  final PhotosRepository photosRepository;

  PhotosUploadUseCaseFromForm(this.photosRepository);

  @override
  Future<Either<Failure, PhotosUploadModel>> call(File image) {
    return photosRepository.uploadPhotoFromForm(image);
  }
}