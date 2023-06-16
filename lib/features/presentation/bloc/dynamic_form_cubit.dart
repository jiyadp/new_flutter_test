import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/data_sources/local/dynamic_form_local_data_source.dart';
import 'package:eminencetel/features/data/models/dynamic_form_model.dart';
import 'package:eminencetel/features/domain/usecase/dynamic_form_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DynamicFormCubit extends Cubit<DataState<DynamicFormModel>> {
  final DynamicFormUseCase dynamicFormUseCase;
  final DynamicFormLocalDataSource dynamicFormLocalDataSourceGetUseCase;
  final DynamicFormLocalDataSource dynamicFormLocalDataSourceSetUseCase;

  DynamicFormCubit(
      this.dynamicFormUseCase,
      this.dynamicFormLocalDataSourceGetUseCase,
      this.dynamicFormLocalDataSourceSetUseCase)
      : super(DataState.initial());

  void getDynamicForm({required DynamicFormParams params}) async {
    emit(DataState.inProgress());
    final result = await dynamicFormUseCase(params);
    result.fold(
        (failure) => {
              emit(DataState.failure("Server Exception"))
            },
        (success) => {
              emit(DataState.success(success))
            });
  }

  DynamicFormData getLocalDynamicFormData() {
    return dynamicFormLocalDataSourceGetUseCase.getUserEnteredData();
  }

  void setDynamicFormData(DynamicFormData params) {
    dynamicFormLocalDataSourceSetUseCase.setUserEnteredData(params);
  }
}
