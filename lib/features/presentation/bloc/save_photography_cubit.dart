import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/data/models/save_photography_model.dart';
import 'package:eminencetel/features/domain/usecase/save_photography_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavePhotographyCubit extends Cubit<DataState<SavePhotographyModel>> {
  final SavePhotographyUseCase savePhotographyUseCase;

  SavePhotographyCubit(this.savePhotographyUseCase)
      : super(DataState.initial());
//todo change FiberHopeModel
  void savePhotography({required CategoriesData params}) async {
    emit(DataState.inProgress());
    final result = await savePhotographyUseCase(params);
    result.fold(
        (failure) => {
              emit(DataState.failure("Server Exception"))
            },
        (success) => {
              if (success.data?.isNotEmpty == true)
                {emit(DataState.success(success))}
              else
                {emit(DataState.empty())}
            });
  }
}
