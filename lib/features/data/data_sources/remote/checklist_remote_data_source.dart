import 'dart:convert';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/features/data/data_sources/local/user_local_data_source.dart';
import 'package:eminencetel/features/data/models/checklist_model.dart';
import 'package:eminencetel/features/domain/usecase/checklist_usecase.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:http/http.dart' as http;

abstract class ChecklistRemoteDataSource {
  Future<ChecklistModel> getChecklist(ChecklistParams params);
}

class ChecklistRemoteDataSourceImpl implements ChecklistRemoteDataSource {
  final http.Client client;
  UserLocalDataSource userLocalDataSource;

  ChecklistRemoteDataSourceImpl(
      {required this.client, required this.userLocalDataSource});

  @override
  Future<ChecklistModel> getChecklist(ChecklistParams params) async {
    final response = await client.post(
        Uri.parse("${LocaleStrings.baseUrl}form/getForms"),
        body: {"userId": userLocalDataSource.getUser().id,"scheduleId": params.scheduleId,});

    if (response.statusCode == 200) {
      return ChecklistModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
