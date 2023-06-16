import 'dart:convert';

import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/features/data/models/fiber_hope_model.dart';
import 'package:eminencetel/features/data/models/save_model.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:http/http.dart' as http;

abstract class SaveRemoteDataSource {
  Future<SaveModel> save(FiberHopeModel params);
  Future<SaveModel> update(FiberHopeModel params);
}

class SaveRemoteDataSourceImpl implements SaveRemoteDataSource {
  final http.Client client;

  SaveRemoteDataSourceImpl({required this.client});

  @override
  Future<SaveModel> save(FiberHopeModel params) async {
    final response = await client.post(
        Uri.parse("${LocaleStrings.baseUrl}sitephotodocumentation/SaveSitePhotogarphyDocumentation"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params.toJson()));
    if (response.statusCode == 200) {
      return SaveModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SaveModel> update(FiberHopeModel params) async {
    final response = await client.post(
        Uri.parse("${LocaleStrings.baseUrl}sitephotodocumentation/UpdateSitePhotogarphyDocumentation"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params.toJson()));
    if (response.statusCode == 200) {
      return SaveModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
