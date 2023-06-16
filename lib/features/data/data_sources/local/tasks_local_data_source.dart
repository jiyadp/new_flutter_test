import 'dart:convert';

import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TasksLocalDataSource {
  setTasks(TasksModel model);

  TasksModel getTasks();
}

const tasks = 'TASKS_DATA';

class TasksLocalDataSourceImpl implements TasksLocalDataSource {
  final SharedPreferences sharedPreferences;

  TasksLocalDataSourceImpl(this.sharedPreferences);

  @override
  TasksModel getTasks() {
    var result = sharedPreferences.getString(tasks);
    if (result?.isNotEmpty == true) {
      return TasksModel.fromJson(json.decode(result!));
    } else {
      return TasksModel();
    }
  }

  @override
  setTasks(TasksModel? model) {
    String cacheString = json.encode(model?.toJson());
    sharedPreferences.setString(tasks, cacheString);
  }
}
