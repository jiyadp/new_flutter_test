import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/schedule_details_model.dart';
import 'package:eminencetel/features/data/models/update_task_status_model.dart';
import 'package:eminencetel/features/domain/usecase/schedule_details_usecase.dart';
import 'package:eminencetel/features/domain/usecase/update_task_status_usecase.dart';
import 'package:eminencetel/features/domain/usecase/user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTaskStatusCubit extends Cubit<DataState<UpdateTaskStatusModel>> {
  final UpdateTaskStatusUseCase updateTaskStatusUseCase;
  final ScheduleDetailsUseCase scheduleDetailsUseCase;
  final UserUseCase userUseCase;

  UpdateTaskStatusCubit(this.updateTaskStatusUseCase,
      this.scheduleDetailsUseCase, this.userUseCase)
      : super(DataState.initial());

  void updateTask(UpdateTaskStatusParams params) async {
    //params.userId = userUseCase.invoke(const NoParams()).id;
    emit(DataState.inProgress());
    final result = await updateTaskStatusUseCase(params);
    result.fold(
        (failure) => emit(DataState.failure("Server Exception")),
        (success) => {
              if (success.data != null)
                {emit(DataState.success(success))}
              else
                {emit(DataState.empty())}
            });
  }

  void updateSchedules(ScheduleDetailsData scheduleDetailsData) {
    scheduleDetailsUseCase.repository.updateSchedules(scheduleDetailsData);
  }
}
