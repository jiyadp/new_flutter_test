import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/dynamic_form_model.dart';
import 'package:eminencetel/features/data/models/save_form_model.dart';
import 'package:eminencetel/features/domain/usecase/save_form_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveFormCubit extends Cubit<DataState<SaveFormModel>> {
  final SaveFormUseCase saveFormUseCase;

  SaveFormCubit(this.saveFormUseCase) : super(DataState.initial());

  saveForm({required DynamicFormData params}) async {
    emit(DataState.inProgress());
    final result = await saveFormUseCase(params);
    result.fold(
        (failure) => {
              emit(DataState.failure("Server Exception"))
            },
        (success) => {
              emit(DataState.success(success))
            });
  }
}
