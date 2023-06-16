import 'package:eminencetel/core/usecases/local_usecase.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/domain/repositories/tasks_repository.dart';

class AllTaskUseCase implements LocalUseCase<TasksModel, String> {
  final TasksRepository repository;

  AllTaskUseCase(this.repository);

  @override
  TasksModel invoke(String userId) {
    return repository.getTasksFromCache(userId);
  }
}
