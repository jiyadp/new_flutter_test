import 'package:eminencetel/features/data/data_sources/local/app_local_data_source.dart';
import 'package:eminencetel/features/data/models/schedule_details_model.dart';
import 'package:eminencetel/features/domain/repositories/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  final AppLocalDataSource appLocalDataSource;

  AppRepositoryImpl(this.appLocalDataSource);

  @override
  int getVersionCode() {
    return appLocalDataSource.getAppVersionCode();
  }

  @override
  setVersionCode(int value) {
    appLocalDataSource.setAppVersionCode(value);
  }

  @override
  ScheduleDetailsData getTaskDetails() {
    return appLocalDataSource.getTaskDetails();
  }

  @override
  setTaskDetails(ScheduleDetailsData schedule) {
    appLocalDataSource.setTaskDetails(schedule);
  }
}
