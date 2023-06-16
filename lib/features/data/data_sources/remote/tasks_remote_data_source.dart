import 'dart:convert';

import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/features/data/data_sources/local/user_local_data_source.dart';
import 'package:eminencetel/features/data/models/tasks_model.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:http/http.dart' as http;

abstract class TasksRemoteDataSource {
  Future<TasksModel> getTasks(String userId);
  Future<TasksModel> getTasksForSchedules(String scheduleId,String userId);
}

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final http.Client client;
  UserLocalDataSource userLocalDataSource;

  TasksRemoteDataSourceImpl(
      {required this.client, required this.userLocalDataSource});

  @override
  Future<TasksModel> getTasks(String userId) async {
    final response = await client
        .post(Uri.parse("${LocaleStrings.baseUrl}task/getTask"), body: {
      "userId": userId,
      "employeeId": userLocalDataSource.getUser().employeeId
    });

    if (response.statusCode == 200) {
      return TasksModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TasksModel> getTasksForSchedules(String scheduleId, String userId) async {
    final response = await client
        .post(Uri.parse("${LocaleStrings.baseUrl}app/getTaskBasedOnSchedule"), body: {
      "scheduleId": scheduleId,
      "userId": userId,
      "employeeId": userLocalDataSource.getUser().employeeId
    });

    if (response.statusCode == 200) {
      return TasksModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
