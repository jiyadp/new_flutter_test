import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/data_sources/local/dynamic_photos_tab_local_data_source.dart';
import 'package:eminencetel/features/data/models/dynamic_photos_tab_model.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/domain/usecase/dynamic_photos_tab_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DynamicPhotosTabCubit extends Cubit<DataState<DynamicPhotosTabModel>> {
  final DynamicPhotosTabUseCase dynamicPhotosTabUseCase;
  final DynamicPhotosTabLocalDataSource
      dynamicPhotosTabLocalDataSourceGetUseCase;
  final DynamicPhotosTabLocalDataSource
      dynamicPhotosTabLocalDataSourceSetUseCase;

  DynamicPhotosTabCubit(
      this.dynamicPhotosTabUseCase,
      this.dynamicPhotosTabLocalDataSourceGetUseCase,
      this.dynamicPhotosTabLocalDataSourceSetUseCase)
      : super(DataState.initial());

  void getDynamicPhotosTabData({required DynamicPhotosTabParams params}) async {
    emit(DataState.inProgress());
    final result = await dynamicPhotosTabUseCase(params);
    result.fold(
        (failure) => {
              emit(DataState.failure("Server Exception")),

            },
        (success) => {
              emit(DataState.success(success)),
            });
  }

  CategoriesData getLocalDynamicPhotosTabData() {
    return dynamicPhotosTabLocalDataSourceGetUseCase.getUserEnteredData();
  }

  void setDynamicFormData(CategoriesData params) {
    dynamicPhotosTabLocalDataSourceSetUseCase.setUserEnteredData(params);
  }
}
