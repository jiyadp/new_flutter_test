import 'package:eminencetel/core/no_params.dart';
import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/schedules_model.dart';
import 'package:eminencetel/features/domain/usecase/schedules_usecase.dart';
import 'package:eminencetel/features/domain/usecase/user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulesCubit extends Cubit<DataState<SchedulesModel>> {
  final SchedulesUseCase schedulesUseCase;
  final UserUseCase userUseCase;

  SchedulesCubit(this.schedulesUseCase, this.userUseCase) : super(DataState.initial());

  void syncTasks() async {
    await schedulesUseCase(userUseCase.invoke(const NoParams()).id ?? "");
  }

  void getSchedules() async {
    emit(DataState.inProgress());
    final result = await schedulesUseCase(userUseCase.invoke(const NoParams()).id ?? "");
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
