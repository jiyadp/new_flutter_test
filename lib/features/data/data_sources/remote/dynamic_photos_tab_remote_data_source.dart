import 'dart:convert';

import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/features/data/data_sources/local/user_local_data_source.dart';
import 'package:eminencetel/features/data/models/dynamic_photos_tab_model.dart';
import 'package:eminencetel/features/domain/usecase/dynamic_photos_tab_usecase.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:http/http.dart' as http;

abstract class DynamicPhotosTabRemoteDataSource {
  Future<DynamicPhotosTabModel> getDynamicPhotosTabData(
      DynamicPhotosTabParams params);
}

class DynamicPhotosTabRemoteDataSourceImpl
    implements DynamicPhotosTabRemoteDataSource {
  final http.Client client;
  UserLocalDataSource userLocalDataSource;

  DynamicPhotosTabRemoteDataSourceImpl(
      {required this.client, required this.userLocalDataSource});

  @override
  Future<DynamicPhotosTabModel> getDynamicPhotosTabData(
      DynamicPhotosTabParams params) async {
    final response = await client.post(
        Uri.parse(
            "${LocaleStrings.baseUrl}photography_group/getPhotogarphyGroup"),
        body: {
          "formId": params.formId,
          "scheduleId": params.scheduleId,
          "userId": userLocalDataSource.getUser().id
        });
    if (response.statusCode == 200) {
      return DynamicPhotosTabModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
