import 'dart:convert';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/features/data/data_sources/local/user_local_data_source.dart';
import 'package:eminencetel/features/data/models/update_task_status_model.dart';
import 'package:eminencetel/features/domain/usecase/update_task_status_usecase.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:http/http.dart' as http;

abstract class UpdateTaskStatusRemoteDataSource {
  Future<UpdateTaskStatusModel> getTaskStatus(UpdateTaskStatusParams params);
}

class UpdateTaskStatusRemoteDataSourceImpl
    implements UpdateTaskStatusRemoteDataSource {
  final http.Client client;
  UserLocalDataSource localDataSource;

  UpdateTaskStatusRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<UpdateTaskStatusModel> getTaskStatus(
      UpdateTaskStatusParams params) async {
    final response = await client.post(
        Uri.parse("${LocaleStrings.baseUrl}task/updateTaskStatus"),
        body: {
          "scheduleId": params.scheduleId,
          "taskNo": params.taskNo,
          "taskStatus": params.taskStatus,
          "comment": params.comments,
          "userId": localDataSource.getUser().id,
        });

    if (response.statusCode == 200) {
      return UpdateTaskStatusModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
