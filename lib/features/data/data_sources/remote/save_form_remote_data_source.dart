import 'dart:convert';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/features/data/models/dynamic_form_model.dart';
import 'package:eminencetel/features/data/models/save_form_model.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:http/http.dart' as http;

abstract class SaveFormRemoteDataSource {
  Future<SaveFormModel> getSaveForm(DynamicFormData params);
}

class SaveFormRemoteDataSourceImpl implements SaveFormRemoteDataSource {
  final http.Client client;

  SaveFormRemoteDataSourceImpl({required this.client});

  @override
  Future<SaveFormModel> getSaveForm(DynamicFormData params) async {
    final response = await client.post(
        Uri.parse("${LocaleStrings.baseUrl}form/saveFormsDetails"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params));
    if (response.statusCode == 200) {
      return SaveFormModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
