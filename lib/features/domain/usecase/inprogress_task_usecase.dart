import 'package:eminencetel/core/usecases/local_usecase.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/domain/repositories/tasks_repository.dart';

class InProgressTaskUseCase implements LocalUseCase<TasksModel, String> {
  final TasksRepository repository;

  InProgressTaskUseCase(this.repository);

  @override
  TasksModel invoke(String userId) {
    var allTasks = repository.getTasksFromCache(userId);
    var updatedTaskList = <TasksData>[];
    allTasks.data?.forEach((element) {
      if (element.task?.taskStatus?.toLowerCase() == "in progress") {
        updatedTaskList.add(element);
      }
    });

    allTasks.data = updatedTaskList;
    return allTasks;
  }
}
