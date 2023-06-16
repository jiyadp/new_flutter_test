import 'package:eminencetel/features/domain/entities/save_response.dart';

class SaveModel extends SaveResponse {
  const SaveModel({List<SaveData>? data, String? message, bool? success})
      : super(data: data, message: message, success: success);

  factory SaveModel.fromJson(Map<String, dynamic> json) => SaveModel(
      data: json['data'] != null
          ? json['data']!
              .map<SaveData>((data) => SaveData.fromJson(data))
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

class SaveData extends SaveDataResponse {
  const SaveData({String? id}) : super(id: id);

  factory SaveData.fromJson(Map<String, dynamic> json) {
    return SaveData(id: json['_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    return data;
  }
}
