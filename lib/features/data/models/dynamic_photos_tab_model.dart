import 'package:eminencetel/features/data/models/photos_model.dart';

class DynamicPhotosTabModel {
  final bool? success;
  final String? message;
  final CategoriesData? categoriesData;

  const DynamicPhotosTabModel(
      {this.success, this.message, this.categoriesData});

  factory DynamicPhotosTabModel.fromJson(Map<String, dynamic> json) =>
      DynamicPhotosTabModel(
        success: json['success'],
        message: json['message'],
        categoriesData:
            json['data'] != null ? CategoriesData.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}
