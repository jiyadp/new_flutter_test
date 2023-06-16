import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/schedule_details_model.dart';
import 'package:eminencetel/features/domain/usecase/buzzer_usecase.dart';
import 'package:eminencetel/features/domain/usecase/schedule_details_usecase.dart';
import 'package:eminencetel/features/presentation/utils/task_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleDetailsCubit extends Cubit<DataState<ScheduleDetailsModel>> {
  final ScheduleDetailsUseCase scheduleDetailsUseCase;
  final BuzzerUseCase buzzerUseCase;

  ScheduleDetailsCubit(this.scheduleDetailsUseCase,this.buzzerUseCase)
      : super(DataState.initial());

  void getScheduleDetails(TaskDataModel taskDataModel) async {
    emit(DataState.inProgress());
    final result = await scheduleDetailsUseCase(taskDataModel);
    result.fold(
        (failure) => emit(DataState.failure("Server Exception")),
        (success) => {
              if (success.data != null)
                {emit(DataState.success(success))}
              else
                {emit(DataState.empty())}
            });
  }

  ScheduleDetailsData getSchedules() {
    return scheduleDetailsUseCase.repository.getSchedules();
  }

  void setTaskDetails(ScheduleDetailsData schedule) {
    buzzerUseCase.setTaskDetails(schedule);
  }
}
