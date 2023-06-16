class ChecklistModel {
  final bool? success;
  final String? message;
  final List<ChecklistData>? data;

  const ChecklistModel({this.success, this.message, this.data});

  factory ChecklistModel.fromJson(Map<String, dynamic> json) => ChecklistModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null
            ? json['data']!
                .map<ChecklistData>((data) => ChecklistData.fromJson(data))
                .toList()
            : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}

class ChecklistData {
  final String? formNo;
  final String? name;
  final String? formId;

  const ChecklistData({this.formNo, this.name, this.formId});

  factory ChecklistData.fromJson(Map<String, dynamic> json) {
    return ChecklistData(
        formNo: json["formNo"], name: json["name"], formId: json["_id"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formNo'] = formNo;
    data['name'] = name;
    return data;
  }

  List<Object?> get props => [formNo, name];
}
