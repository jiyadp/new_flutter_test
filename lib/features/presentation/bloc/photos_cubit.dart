import 'package:eminencetel/core/no_params.dart';
import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/domain/usecase/photos_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotosCubit extends Cubit<DataState<PhotosModel>> {
  final PhotosUseCase photosUseCase;

  PhotosCubit(this.photosUseCase) : super(DataState.initial());

  void getPhotos() async {
    emit(DataState.inProgress());
    final result = await photosUseCase(const NoParams());
    result.fold(
        (failure) => emit(DataState.failure("Server Exception")),
        (success) => {
              if (success.data?.isNotEmpty == true)
                {emit(DataState.success(success))}
              else
                {emit(DataState.empty())}
            });
  }
}
