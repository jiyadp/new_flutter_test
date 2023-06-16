import 'dart:convert';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/features/data/data_sources/local/user_local_data_source.dart';
import 'package:eminencetel/features/data/models/schedules_model.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:http/http.dart' as http;

abstract class SchedulesRemoteDataSource {
  Future<SchedulesModel> getSchedules(String userId);
}

class SchedulesRemoteDataSourceImpl implements SchedulesRemoteDataSource {
  final http.Client client;
  UserLocalDataSource userLocalDataSource;

  SchedulesRemoteDataSourceImpl({
    required this.client,
    required this.userLocalDataSource
  });

  @override
  Future<SchedulesModel> getSchedules(String userId) async {
    final response = await client
        .post(Uri.parse("${LocaleStrings.baseUrl}app/getSchedules"), body: {
      "userId": userId,
      "employeeId": userLocalDataSource.getUser().employeeId
    });

    if (response.statusCode == 200) {
      return SchedulesModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
