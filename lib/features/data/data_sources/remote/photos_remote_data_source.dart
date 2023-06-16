import 'dart:convert';
import 'dart:io';
import 'package:eminencetel/core/error/exceptions.dart';
import 'package:eminencetel/core/no_params.dart';
import 'package:eminencetel/features/data/models/photo_upload_model.dart';
import 'package:eminencetel/features/data/models/photos_model.dart';
import 'package:eminencetel/features/domain/usecase/photos_upload_usecase.dart';
import 'package:eminencetel/features/presentation/res/locale_strings.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

abstract class PhotosRemoteDataSource {
  Future<PhotosModel> getPhotos(NoParams params);

  Future<PhotosUploadModel> uploadPhotos(PhotoParams params);

  // Photo from Dynamic form
  Future<PhotosUploadModel> uploadPhoto(File params);
}

class PhotosRemoteDataSourceImpl implements PhotosRemoteDataSource {
  final http.Client client;

  PhotosRemoteDataSourceImpl({required this.client});

  @override
  Future<PhotosModel> getPhotos(NoParams noParams) async {
    final response = await client.post(Uri.parse(
        "${LocaleStrings.baseUrl}photography_group/getActivePhotogarphyGroup"));

    if (response.statusCode == 200) {
      return PhotosModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PhotosUploadModel> uploadPhotos(PhotoParams params) async {
    Map<String, String> headers = {
      // 'authorization': header,
      // 'token': token,
      'Content-Type': 'multipart/form-data',
    };
    var request = http.MultipartRequest(
      "POST",
      Uri.parse('${LocaleStrings.baseUrl}Upload/PhotograhyFileUpload'),
    );

    request.headers.addAll(headers);

    request.files.add(
      http.MultipartFile.fromBytes(
        "UploadImage",
        params.imageId.readAsBytesSync(),
        filename: params.imageId.path.split("/").last,
        contentType:
            MediaType("UploadImage", params.imageId.path.split(".").last),
      ),
    );
    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      return PhotosUploadModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PhotosUploadModel> uploadPhoto(File params) async {
    Map<String, String> headers = {
      // 'authorization': header,
      // 'token': token,
      'Content-Type': 'multipart/form-data',
    };
    var request = http.MultipartRequest(
      "POST",
      Uri.parse('${LocaleStrings.baseUrl}Upload/PhotograhyFileUpload'),
    );

    request.headers.addAll(headers);

    request.files.add(
      http.MultipartFile.fromBytes(
        "UploadImage",
        params.readAsBytesSync(),
        filename: params.path.split("/").last,
        contentType:
        MediaType("UploadImage", params.path.split(".").last),
      ),
    );
    http.Response response =
    await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      return PhotosUploadModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
