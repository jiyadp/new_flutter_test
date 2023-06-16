import 'package:eminencetel/core/no_params.dart';
import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/domain/usecase/all_tasks_usecase.dart';
import 'package:eminencetel/features/domain/usecase/finished_task_usecase.dart';
import 'package:eminencetel/features/domain/usecase/inprogress_task_usecase.dart';
import 'package:eminencetel/features/domain/usecase/scheduled_tasks_usecase.dart';
import 'package:eminencetel/features/domain/usecase/tasks_usecase.dart';
import 'package:eminencetel/features/domain/usecase/todays_tasks_usecase.dart';
import 'package:eminencetel/features/domain/usecase/unfinished_task_usecase.dart';
import 'package:eminencetel/features/domain/usecase/user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksCubit extends Cubit<DataState<TasksModel>> {
  final TasksUseCase taskUseCase;
  final ScheduledTasksUseCase scheduledTasksUseCase;
  final TodayTasksUseCase todayTasksUseCase;
  final UnFinishedTaskUseCase unFinishedTaskUseCase;
  final InProgressTaskUseCase inProgressTaskUseCase;
  final FinishedTaskUseCase finishedTaskUseCase;
  final UserUseCase userUseCase;
  final AllTaskUseCase allTaskUseCase;

  TasksCubit(
      this.taskUseCase,
      this.scheduledTasksUseCase,
      this.userUseCase,
      this.todayTasksUseCase,
      this.unFinishedTaskUseCase,
      this.finishedTaskUseCase,
      this.inProgressTaskUseCase,
      this.allTaskUseCase)
      : super(DataState.initial());

  void syncTasks() async {
    await taskUseCase(userUseCase.invoke(const NoParams()).id ?? "");
  }

  void getTasks() async {
    emit(DataState.inProgress());
    final result =
        await taskUseCase(userUseCase.invoke(const NoParams()).id ?? "");
    result.fold(
        (failure) => emit(DataState.failure("Server Exception")),
        (success) => {
              if (success.data?.isNotEmpty == true)
                {emit(DataState.success(success))}
              else
                {emit(DataState.empty())}
            });
  }

  TasksModel? getAllTasks() {
    return allTaskUseCase.invoke(userUseCase.invoke(const NoParams()).id ?? "");
  }

  void getTasksForSchedules(String scheduleId) async {
    emit(DataState.inProgress());
    var userId = userUseCase.invoke(const NoParams()).id ?? "";
    final result = await scheduledTasksUseCase(ScheduleTaskParams(scheduleId: scheduleId, userId: userId));
    result.fold(
            (failure) => emit(DataState.failure("Server Exception")),
            (success) => {
          if (success.data?.isNotEmpty == true)
            {emit(DataState.success(success))}
          else
            {emit(DataState.empty())}
        });
  }

  void getTodaysTasks() async {
    emit(DataState.inProgress());
    final result =
        todayTasksUseCase.invoke(userUseCase.invoke(const NoParams()).id ?? "");
    if (result.data?.isEmpty == true) {
      emit(DataState.empty());
    } else {
      emit(DataState.success(result));
    }
  }

  void getUnFinishedTasks() async {
    emit(DataState.inProgress());
    final result = unFinishedTaskUseCase
        .invoke(userUseCase.invoke(const NoParams()).id ?? "");
    if (result.data?.isEmpty == true) {
      emit(DataState.empty());
    } else {
      emit(DataState.success(result));
    }
  }

  void getFinishedTasks() async {
    emit(DataState.inProgress());
    final result = finishedTaskUseCase
        .invoke(userUseCase.invoke(const NoParams()).id ?? "");
    if (result.data?.isEmpty == true) {
      emit(DataState.empty());
    } else {
      emit(DataState.success(result));
    }
  }

  int getUnFinishedTasksCount() {
    final result = unFinishedTaskUseCase
        .invoke(userUseCase.invoke(const NoParams()).id ?? "");
    return result.data?.length ?? 0;
  }

  void getInProgressTasks() async {
    emit(DataState.inProgress());
    final result = inProgressTaskUseCase
        .invoke(userUseCase.invoke(const NoParams()).id ?? "");
    if (result.data?.isEmpty == true) {
      emit(DataState.empty());
    } else {
      emit(DataState.success(result));
    }
  }
}
