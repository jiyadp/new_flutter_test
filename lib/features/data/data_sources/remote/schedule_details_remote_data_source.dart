import 'dart:convert';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/features/data/models/schedule_details_model.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:eminencetel/features/presentation/utils/task_data_model.dart';
import 'package:http/http.dart' as http;

abstract class ScheduleDetailsRemoteDataSource {
  Future<ScheduleDetailsModel> getScheduleDetails(TaskDataModel taskDataModel);
}

class ScheduleDetailsRemoteDataSourceImpl
    implements ScheduleDetailsRemoteDataSource {
  final http.Client client;

  ScheduleDetailsRemoteDataSourceImpl({required this.client});

  @override
  Future<ScheduleDetailsModel> getScheduleDetails(
      TaskDataModel taskDataModel) async {
    final response = await client
        .post(Uri.parse("${LocaleStrings.baseUrl}task/getTaskById"), body: {
      "scheduleId": taskDataModel.scheduleId,
      "taskNo": taskDataModel.taskNo
    });
    if (response.statusCode == 200) {
      return ScheduleDetailsModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
