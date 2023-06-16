import 'package:eminencetel/core/usecases/local_usecase.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/domain/repositories/tasks_repository.dart';

class FinishedTaskUseCase implements LocalUseCase<TasksModel, String> {
  final TasksRepository repository;

  FinishedTaskUseCase(this.repository);

  @override
  TasksModel invoke(String userId) {
    var allTasks = repository.getTasksFromCache(userId);
    var updatedTaskList = <TasksData>[];
    allTasks.data?.forEach((element) {
      if(element.task?.taskStatus?.toLowerCase() == "finished" || element.task?.taskStatus?.toLowerCase() == "done" || element.task?.taskStatus?.toLowerCase() == "completed") {
        updatedTaskList.add(element);
      }
    });

    allTasks.data = updatedTaskList;
    return allTasks;
  }
}
