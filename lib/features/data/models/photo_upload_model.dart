import 'package:eminencetel/features/domain/entities/photos_upload_response.dart';

class PhotosUploadModel extends PhotosUploadResponse {
  const PhotosUploadModel({String? data, String? message, bool? success})
      : super(data: data, message: message, success: success);

  factory PhotosUploadModel.fromJson(Map<String, dynamic> json) =>
      PhotosUploadModel(
          data: json['data'],
          message: json['message'],
          success: json['success']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data;
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}
