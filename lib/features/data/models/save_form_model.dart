class SaveFormModel {
  final bool? success;
  final String? message;
  final SaveFormData? data;

  const SaveFormModel({this.success, this.message, this.data});

  factory SaveFormModel.fromJson(Map<String, dynamic> json) => SaveFormModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? SaveFormData.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}

class SaveFormData {
  final String? formNo;
  final String? name;

  const SaveFormData({this.formNo, this.name});

  factory SaveFormData.fromJson(Map<String, dynamic> json) {
    return SaveFormData(
      formNo: json["formNo"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formNo'] = formNo;
    data['name'] = name;
    return data;
  }

  List<Object?> get props => [formNo, name];
}
