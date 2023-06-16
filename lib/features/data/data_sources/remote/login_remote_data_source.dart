import 'dart:convert';

import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/features/data/models/login_model.dart';
import 'package:eminencetel/features/domain/usecase/login_usecase.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:http/http.dart' as http;

abstract class LoginRemoteDataSource {
  Future<LoginModel> login(LoginParams params);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginModel> login(LoginParams params) async {
    final response = await client.post(
        Uri.parse("${LocaleStrings.baseUrl}login"),
        body: {"email": "adarshanikumar92@gmail.com", "password": params.password});

    if (response.statusCode == 200) {
      return LoginModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
