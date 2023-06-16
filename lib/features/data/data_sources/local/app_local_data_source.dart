import 'dart:convert';
import 'package:eminencetel/features/data/models/schedule_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppLocalDataSource {
  setAppVersionName(String value);

  setAppVersionCode(int value);

  String getAppVersionName();

  int getAppVersionCode();

  setTaskDetails(ScheduleDetailsData schedule);

  ScheduleDetailsData getTaskDetails();
}

const appVersionName = 'APP_VERSION_NAME';
const appVersionCode = 'APP_VERSION_CODE';
const schedule = 'SCHEDULE';
const buzzerInterval = 'BUZZER_INTERVAL';

class AppLocalDataSourceImpl implements AppLocalDataSource {
  final SharedPreferences sharedPreferences;

  AppLocalDataSourceImpl(this.sharedPreferences);

  @override
  int getAppVersionCode() {
    var result = sharedPreferences.getInt(appVersionCode);
    return result ?? 0;
  }

  @override
  String getAppVersionName() {
    var result = sharedPreferences.getString(appVersionName);
    return result ?? "";
  }

  @override
  setAppVersionCode(int value) async {
    await sharedPreferences.setInt(appVersionCode, value);
  }

  @override
  setAppVersionName(String value) async {
    await sharedPreferences.setString(appVersionName, value);
  }

  @override
  ScheduleDetailsData getTaskDetails() {
    var result = sharedPreferences.getString(schedule);
    if (result?.isNotEmpty == true) {
      return ScheduleDetailsData.fromJson(json.decode(result!));
    } else {
      return const ScheduleDetailsData();
    }
  }

  @override
  setTaskDetails(ScheduleDetailsData scheduleData) async {
    String scheduleString = json.encode(scheduleData.toJson());
    await sharedPreferences.setString(schedule, scheduleString);
  }
}
