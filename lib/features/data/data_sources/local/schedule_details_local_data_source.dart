import 'dart:convert';
import 'package:eminencetel/features/data/models/schedule_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ScheduleDetailsLocalDataSource {
  setScheduleDetails(ScheduleDetailsData? scheduleDetailsData);

  ScheduleDetailsData getSchedules();
}

const scheduleDetails = 'SCHEDULE_DETAILS_DATA';

class ScheduleDetailsLocalDataSourceImpl
    implements ScheduleDetailsLocalDataSource {
  final SharedPreferences sharedPreferences;

  ScheduleDetailsLocalDataSourceImpl(this.sharedPreferences);

  @override
  ScheduleDetailsData getSchedules() {
    var result = sharedPreferences.getString(scheduleDetails);
    if (result?.isNotEmpty == true) {
      return ScheduleDetailsData.fromJson(json.decode(result!));
    } else {
      return const ScheduleDetailsData();
    }
  }

  @override
  setScheduleDetails(ScheduleDetailsData? scheduleDetailsData) async {
    String scheduleDataString = json.encode(scheduleDetailsData?.toJson());
    await sharedPreferences.setString(scheduleDetails, scheduleDataString);
  }
}
