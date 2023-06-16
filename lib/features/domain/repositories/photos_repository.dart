import 'package:eminencetel/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'dart:io';
import 'package:eminencetel/core/no_params.dart';
import 'package:eminencetel/features/data/models/photo_upload_model.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/domain/usecase/photos_upload_usecase.dart';

abstract class PhotosRepository {
  Future<Either<Failure, PhotosModel>> getPhotos(NoParams params);

  // Upload photos from photos tab.
  Future<Either<Failure, PhotosUploadModel>> uploadPhotos(PhotoParams params);

  // Upload photos from dynamic form
  Future<Either<Failure, PhotosUploadModel>> uploadPhotoFromForm(File file);

}
