import 'package:intl/intl.dart';

class TasksModel {
  final bool? success;
  final String? message;
  List<TasksData>? data;

  TasksModel({this.success, this.message, this.data});

  factory TasksModel.fromJson(Map<String, dynamic> json) => TasksModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null
            ? json['data']!
                .map<TasksData>((data) => TasksData.fromJson(data))
                .toList()
            : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> mapData = <String, dynamic>{};
    mapData['success'] = success;
    mapData['message'] = message;
    mapData['data'] = data;
    return mapData;
  }
}

class TasksData {
  final String? id;
  final String? project;
  final String? scheduleNo;
  final Site? site;
  final Task? task;
  final String? operator;

  const TasksData(
      {this.id,
      this.project,
      this.site,
      this.task,
      this.scheduleNo,
      this.operator});

  factory TasksData.fromJson(Map<String, dynamic> json) {
    return TasksData(
        id: json['_id'],
        project: json['project'],
        site: Site.fromJson(json['site']),
        task: Task.fromJson(json['task']),
        scheduleNo: json['scheduleNo'],
        operator: json["operator"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['project'] = project;
    data['site'] = site;
    data['task'] = task;
    data['scheduleNo'] = scheduleNo;
    data['operator'] = operator;

    return data;
  }

  List<Object?> get props => [id, project, site, task, scheduleNo, operator];
}

class Site {
  final String? id;
  final String? name;
  final String? address;
  final String? type;
  final String? postCode;
  final String? latitude;
  final String? longitude;
  final String? threeUkId;
  final String? tmobileId;
  final String? operatorId;
  final String? tefId;
  final String? ctilId;

  const Site(
      {this.id,
      this.name,
      this.address,
      this.type,
      this.postCode,
      this.latitude,
      this.longitude,
      this.threeUkId,
      this.tmobileId,
      this.operatorId,
      this.tefId,
      this.ctilId});

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      type: json['type'],
      postCode: json['postCode'],
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
      threeUkId: json['threeUkId'].toString(),
      tmobileId: json['TmobileId'].toString(),
      operatorId: json['operatorId'].toString(),
      ctilId: json['ctilId'].toString(),
      tefId: json['tefId'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['type'] = type;
    data['postCode'] = postCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['threeUkId'] = threeUkId;
    data['TmobileId'] = tmobileId;
    data['operatorId'] = operatorId;
    data['ctilId'] = ctilId;
    data['tefId'] = tefId;
    return data;
  }

  List<Object?> get props =>
      [id, name, address, type, postCode, latitude, longitude, threeUkId];
}

class Task {
  final String? startDate;
  final Time? startTime;
  final String? endDate;
  final Time? endTime;
  final String? scope;
  final String? crq;
  final String? team;
  final bool? buzzer;
  final int? buzzerInterval;
  final int? buzzerDuration;
  final String? selectDrop;
  String? taskStatus;
  final String? taskNo;
  final Outage? outage;
  final List<String>? staffMember;
  List<Comments>? comments;

  Task(
      {this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      this.scope,
      this.crq,
      this.selectDrop,
      this.taskStatus,
      this.outage,
      this.taskNo,
      this.team,
      this.buzzer,
      this.buzzerInterval,
      this.buzzerDuration,
      this.comments,
      this.staffMember});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      startDate: json['startDate'],
      startTime: Time.fromJson(json['startTime']),
      endDate: json['endDate'],
      endTime: Time.fromJson(json['endTime']),
      scope: json['scope'],
      crq: json['crq'],
      selectDrop: json['selectdrop'],
      outage: Outage.fromJson(json['outage']),
      taskStatus: json['taskStatus'].toString(),
      taskNo: json['taskNo'],
      team: json['team'],
      buzzer: json['buzzer'] ?? false,
      buzzerInterval: json['buzzerInterval'],
      buzzerDuration: json['buzzerDuration'],
      staffMember: json['staffMember'] != null
          ? json['staffMember']!
              .map<String>((data) => (data as String).trim())
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = startDate;
    data['startTime'] = startTime;
    data['endDate'] = endDate;
    data['endTime'] = endTime;
    data['scope'] = scope;
    data['crq'] = crq;
    data['team'] = team;
    data['buzzer'] = buzzer;
    data['buzzerInterval'] = buzzerInterval;
    data['buzzerDuration'] = buzzerDuration;
    data['selectdrop'] = selectDrop;
    data['taskStatus'] = taskStatus;
    data['taskNo'] = taskNo;
    data['outage'] = outage;
    data['comments'] = comments;
    data['staffMember'] = staffMember;
    return data;
  }

  List<Object?> get props => [
        startDate,
        startTime,
        endDate,
        endTime,
        scope,
        crq,
        selectDrop,
        taskStatus,
        taskNo,
        outage,
        comments,
        team
      ];
}

class Time {
  final int? hour;
  final int? minute;
  final int? second;

  const Time({this.hour, this.minute, this.second});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
        hour: json['hour'], minute: json['minute'], second: json['second']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hour'] = hour;
    data['minute'] = minute;
    data['second'] = second;
    return data;
  }

  List<Object?> get props => [hour, minute, second];
}

class Outage {
  final String? id;
  final String? outage;
  final int? isActive;

  const Outage({this.id, this.outage, this.isActive});

  factory Outage.fromJson(Map<String, dynamic> json) {
    return Outage(
        id: json['_id'], outage: json['strOutage'], isActive: json['isActive']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['strOutage'] = outage;
    data['isActive'] = isActive;
    return data;
  }

  List<Object?> get props => [id, outage, isActive];
}

class Comments {
  final String? date;
  final String? comment;
  final User? user;

  const Comments({this.date, this.comment, this.user});

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
        date: json['date'],
        comment: json['comment'],
        user: User.fromJson(json['user']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date?.toString();
    data['comment'] = comment;
    data['user'] = user;
    return data;
  }

  static String formattedDate(String date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(DateTime.parse(date));
  }
}

class User {
  final String? id;
  final String? name;
  final String? email;

  const User({this.id, this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    return data;
  }

  List<Object?> get props => [id, name, email];
}
