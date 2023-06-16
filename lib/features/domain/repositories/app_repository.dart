import 'package:eminencetel/features/data/models/schedule_details_model.dart';

abstract class AppRepository {
  setVersionCode(int value);

  int getVersionCode();

  setTaskDetails(ScheduleDetailsData schedules);

  ScheduleDetailsData getTaskDetails();
}
