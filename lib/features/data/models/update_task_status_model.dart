import 'package:eminencetel/features/data/models/tasks_model.dart';

class UpdateTaskStatusModel {
  final bool? success;
  final String? message;
  final UpdateTaskStatusData? data;

  const UpdateTaskStatusModel({this.success, this.message, this.data});

  factory UpdateTaskStatusModel.fromJson(Map<String, dynamic> json) =>
      UpdateTaskStatusModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null
            ? UpdateTaskStatusData.fromJson(json['data'])
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

class UpdateTaskStatusData {
  String? taskStatus;
  String? date;
  String? comment;
  User? user;
  UpdateTaskStatusData({this.taskStatus,this.date,this.comment,this.user});

  factory UpdateTaskStatusData.fromJson(Map<String, dynamic> json) {
    return UpdateTaskStatusData(
        taskStatus: json['taskStatus'],
        date: json['date'],
        comment: json['comment'],
        user: json['user'] != null
            ? User.fromJson(json['user'])
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskStatus'] = taskStatus;
    data['date'] = date;
    data['comment'] = comment;
    data['user'] = user;

    return data;
  }

  List<Object?> get props => [
        taskStatus,date,comment,user
      ];
}
