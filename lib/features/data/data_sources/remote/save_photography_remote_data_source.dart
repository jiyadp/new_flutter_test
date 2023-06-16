import 'dart:convert';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/data/models/save_photography_model.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:http/http.dart' as http;

abstract class SavePhotographyRemoteDataSource {
  Future<SavePhotographyModel> savePhotography(CategoriesData params);
}

class SavePhotographyRemoteDataSourceImpl
    implements SavePhotographyRemoteDataSource {
  final http.Client client;

  SavePhotographyRemoteDataSourceImpl({required this.client});

  @override
  Future<SavePhotographyModel> savePhotography(CategoriesData params) async {
    final response = await client.post(
        Uri.parse("${LocaleStrings.baseUrl}sitephotodocumentation/SaveSitePhotogarphyDocumentation"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params));
    if (response.statusCode == 200) {
      return SavePhotographyModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
