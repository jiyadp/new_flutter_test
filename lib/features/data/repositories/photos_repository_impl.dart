import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/error/failure.dart';
import 'package:eminencetel/core/no_params.dart';
import 'package:eminencetel/features/data/data_sources/remote/photos_remote_data_source.dart';
import 'package:eminencetel/features/data/models/photo_upload_model.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/domain/repositories/photos_repository.dart';
import 'package:eminencetel/features/domain/usecase/photos_upload_usecase.dart';
import 'package:eminencetel/features/presentation/bloc/dynamic_photos_tab_cubit.dart';
import 'package:eminencetel/injection_container.dart';

class PhotosRepositoryImpl implements PhotosRepository {
  final PhotosRemoteDataSource photosRemoteDataSource;

  PhotosRepositoryImpl(this.photosRemoteDataSource);

  @override
  Future<Either<Failure, PhotosModel>> getPhotos(NoParams params) async {
    try {
      return Right(await photosRemoteDataSource.getPhotos(params));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PhotosUploadModel>> uploadPhotos(
      PhotoParams params) async {
    final DynamicPhotosTabCubit dynamicPhotosTabCubit =
        getIt<DynamicPhotosTabCubit>();
    try {
      var result = await photosRemoteDataSource.uploadPhotos(params);
      var uploadedUrl = result.data;
      if (uploadedUrl?.isNotEmpty == true) {
        var imageList = params.imagesList;
        var image = params.imagesList.photosTabList?[params.tabPosition]
                .photosSelectionList?[params.imagePosition]?.images ??
            [];
        image.add(uploadedUrl ?? "");
        // updating fiber model

        imageList.photosTabList?[params.tabPosition]
            .photosSelectionList?[params.imagePosition]?.images = image;
        dynamicPhotosTabCubit.dynamicPhotosTabLocalDataSourceGetUseCase
            .setUserEnteredData(imageList);
      }
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PhotosUploadModel>> uploadPhotoFromForm(File params) async{
    try {
      var result = await photosRemoteDataSource.uploadPhoto(params);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // In uploadPhotos function sending all the photos tab object
  // and after uploading the photos we are getting the image url from the server
  // need to call the form saving API after image upload

  // confirm if the form saving API is invoked during the cta of next button.

  //






}
