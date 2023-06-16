import 'package:eminencetel/features/domain/entities/save_photography_response.dart';

class SavePhotographyModel extends SavePhotographyResponse {
  const SavePhotographyModel(
      {List<SavePhotographyData>? data, String? message, bool? success})
      : super(data: data, message: message, success: success);

  factory SavePhotographyModel.fromJson(Map<String, dynamic> json) =>
      SavePhotographyModel(
          data: json['data'] != null
              ? json['data']!
                  .map<SavePhotographyData>(
                      (data) => SavePhotographyData.fromJson(data))
                  .toList()
              : null,
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

class SavePhotographyData extends SavePhotographyDataResponse {
  const SavePhotographyData({String? id}) : super(id: id);

  factory SavePhotographyData.fromJson(Map<String, dynamic> json) {
    return SavePhotographyData(id: json['_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    return data;
  }
}
