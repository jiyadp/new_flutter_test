import 'dart:convert';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/features/data/models/dynamic_form_model.dart';
import 'package:eminencetel/features/domain/usecase/dynamic_form_usecase.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:http/http.dart' as http;

abstract class DynamicFormRemoteDataSource {
  Future<DynamicFormModel> getDynamicForm(DynamicFormParams params);
}

class DynamicFormRemoteDataSourceImpl implements DynamicFormRemoteDataSource {
  final http.Client client;

  DynamicFormRemoteDataSourceImpl({required this.client});

  @override
  Future<DynamicFormModel> getDynamicForm(DynamicFormParams params) async {
    //todo please check before commit server issue
    final response = await client
        .post(Uri.parse("${LocaleStrings.baseUrl}form/getFormsById"), body: {
      "id": params.formId,
      "scheduleId": params.scheduleId,
    });
    if (response.statusCode == 200) {
      return DynamicFormModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
