import 'dart:convert';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/features/data/models/certificates_model.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:http/http.dart' as http;

abstract class CertificatesRemoteDataSource {
  Future<CertificatesModel> getCertificates(String userId);
}

class CertificatesRemoteDataSourceImpl implements CertificatesRemoteDataSource {
  final http.Client client;

  CertificatesRemoteDataSourceImpl({required this.client});

  @override
  Future<CertificatesModel> getCertificates(String userId) async {
    final response = await client.post(
        Uri.parse("${LocaleStrings.baseUrl}certification/getCertification"),
        body: {"userId": userId});
    if (response.statusCode == 200) {
      return CertificatesModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
