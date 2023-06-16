import 'package:eminencetel/core/states/data_state.dart';
import 'package:eminencetel/features/data/models/checklist_model.dart';
import 'package:eminencetel/features/domain/usecase/checklist_usecase.dart';
import 'package:eminencetel/features/domain/usecase/schedule_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChecklistCubit extends Cubit<DataState<ChecklistModel>> {
  final ChecklistUseCase checklistUseCase;
  final ScheduleDetailsUseCase scheduleDetailsUseCase;

  ChecklistCubit(this.checklistUseCase,this.scheduleDetailsUseCase) : super(DataState.initial());

  void getChecklist({required ChecklistParams params}) async {
    emit(DataState.inProgress());
    var scheduleId = scheduleDetailsUseCase.repository.getSchedules().id;
    final result = await checklistUseCase(ChecklistParams(formNo: "",scheduleId: scheduleId));
    result.fold(
        (failure) => {
              emit(DataState.failure("Server Exception")),
            },
        (success) => {
              emit(DataState.success(success)),
            });
  }
}
