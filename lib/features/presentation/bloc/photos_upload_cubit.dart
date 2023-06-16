import 'dart:io';
import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/photo_upload_model.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/domain/usecase/photos_upload_usecase.dart';
import 'package:eminencetel/features/domain/usecase/photos_upload_usecase_from_from.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotosUploadCubit extends Cubit<DataState<PhotosUploadModel>> {
  final PhotosUploadUseCase photosUploadUseCase;
  final PhotosUploadUseCaseFromForm photosUploadUseCaseFromForm;

  PhotosUploadCubit(this.photosUploadUseCase,this.photosUploadUseCaseFromForm) : super(DataState.initial());

  // Upload photos from photo tab
  void uploadPhotos({
    required File imageId,
    required CategoriesData imagesList,
    required int tabPosition,
    required int imagePosition,
  }) async {
    emit(DataState.inProgress());

    final result = await photosUploadUseCase(PhotoParams(
        imageId: imageId,
        imagesList: imagesList,
        tabPosition: tabPosition,
        imagePosition: imagePosition));
    result.fold(
        (failure) => {emit(DataState.failure("Server Exception"))},
        (success) => {
              if (success.data?.isNotEmpty == true)
                {emit(DataState.success(success))}
              else
                {emit(DataState.empty())}
            });
  }

  // Upload Photo from Dynamic form
  void uploadPhoto({required File imageId}) async {
    emit(DataState.inProgress());
    final result = await photosUploadUseCaseFromForm(imageId);
    result.fold(
            (failure) => {emit(DataState.failure("Server Exception"))},
            (success) => {
          if (success.data?.isNotEmpty == true)
            {emit(DataState.success(success))}
          else
            {emit(DataState.empty())}
        });
  }

  void refreshPhoto() {
    Future.delayed(const Duration(milliseconds: 5000), () {
      emit(DataState.success(const PhotosUploadModel()));
    });
  }

  void showProgress(){
    emit(DataState.inProgress());
  }

  void hideProgress(){
    emit(DataState.empty());
  }


}
