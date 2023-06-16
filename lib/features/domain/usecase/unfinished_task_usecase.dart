import 'package:eminencetel/core/usecases/local_usecase.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/domain/repositories/tasks_repository.dart';
import 'package:intl/intl.dart';

class UnFinishedTaskUseCase implements LocalUseCase<TasksModel, String> {
  final TasksRepository repository;

  UnFinishedTaskUseCase(this.repository);

  @override
  TasksModel invoke(String userId) {
    var allTasks = repository.getTasksFromCache(userId);
    var updatedTaskList = <TasksData>[];
    allTasks.data?.forEach((element) {
      var formatter = DateFormat('yyyy-MM-dd');
      var formattedDate =
          formatter.format(DateTime.parse("${element.task?.startDate}"));
      var formattedTodayDate = formatter.format(DateTime.now());

      if (DateTime.parse(formattedDate)
              .isAfter(DateTime.parse(formattedTodayDate)) &&
          element.task?.taskStatus?.toLowerCase() == "scheduled") {
        updatedTaskList.add(element);
      }
    });

    allTasks.data = updatedTaskList;
    return allTasks;
  }
}
