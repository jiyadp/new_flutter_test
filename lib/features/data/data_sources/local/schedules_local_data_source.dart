import 'dart:convert';

import 'package:eminencetel/features/data/models/schedules_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SchedulesLocalDataSource {
  setSchedules(SchedulesModel model);

  SchedulesModel getSchedules();
}

const tasks = 'SCHEDULES_DATA';

class SchedulesLocalDataSourceImpl implements SchedulesLocalDataSource {
  final SharedPreferences sharedPreferences;

  SchedulesLocalDataSourceImpl(this.sharedPreferences);

  @override
  SchedulesModel getSchedules() {
    var result = sharedPreferences.getString(tasks);
    if (result?.isNotEmpty == true) {
      return SchedulesModel.fromJson(json.decode(result!));
    } else {
      return SchedulesModel();
    }
  }

  @override
  setSchedules(SchedulesModel? model) {
    String cacheString = json.encode(model?.toJson());
    sharedPreferences.setString(tasks, cacheString);
  }
}
