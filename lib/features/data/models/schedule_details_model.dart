import 'package:eminencetel/features/data/models/tasks_model.dart';

class ScheduleDetailsModel {
  final bool? success;
  final String? message;
  final ScheduleDetailsData? data;

  const ScheduleDetailsModel({this.success, this.message, this.data});

  factory ScheduleDetailsModel.fromJson(Map<String, dynamic> json) =>
      ScheduleDetailsModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null
            ? ScheduleDetailsData.fromJson(json['data'])
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

class ScheduleDetailsData {
  final String? id;
  final Site? site;
  final Task? task;
  final Project? project;
  final String? cellId;
  final String? operator;
  final String? accessRequestApproval;
  final String? poRequestApproval;
  final String? staffMember;
  final String? projectNo;
  final Object? scheduleStatus;
  final String? projectManager;
  final String? subContractor;
  final String? scheduledNo;
  final List<Documents?>? documents;

  const ScheduleDetailsData({
    this.id,
    this.site,
    this.task,
    this.cellId,
    this.operator,
    this.accessRequestApproval,
    this.poRequestApproval,
    this.project,
    this.staffMember,
    this.projectNo,
    this.scheduleStatus,
    this.scheduledNo,
    this.subContractor,
    this.documents,
    this.projectManager,
  });

  factory ScheduleDetailsData.fromJson(Map<String, dynamic> json) {
    return ScheduleDetailsData(
      id: json['_id'],
      site: Site.fromJson(json['site']),
      task: Task.fromJson(json['task']),
      cellId: json['cellID'],
      operator: json['operator'].toString(),
      accessRequestApproval: json['accessDrop'],
      poRequestApproval: json['poDrop'],
      staffMember: json['staffMember'],
      projectNo: json['projectNo'].toString(),
      scheduleStatus: json['scheduleStatus'],
      subContractor: json['subContractor'],
      scheduledNo: json['scheduleNo'],
      projectManager: json['projectManager'],
      project: Project.fromJson(
        json['project'],
      ),
      documents: json['documents'] != null
          ? json['documents']!
              .map<Documents>((data) => Documents.fromJson(data))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['site'] = site;
    data['task'] = task;
    data['cellID'] = cellId;
    data['operator'] = operator;
    data['accessDrop'] = accessRequestApproval;
    data['poDrop'] = poRequestApproval;
    data['staffMember'] = staffMember;
    data['project'] = project;
    data['projectNo'] = projectNo;
    data['scheduleStatus'] = scheduleStatus;
    data['subContractor'] = subContractor;
    data['scheduleNo'] = scheduledNo;
    data['documents'] = documents;
    data['projectManager'] = projectManager;
    return data;
  }

  List<Object?> get props => [
        id,
        site,
        task,
        cellId,
        operator,
        accessRequestApproval,
        project,
        projectNo,
        scheduleStatus,
        subContractor,
        scheduledNo,
        documents,
        projectManager
      ];
}

class Project {
  final String? name;
  final String? id;

  const Project({this.name, this.id});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(name: json['projectName'], id: json["_id"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['projectName'] = name;
    data['_id'] = id;
    return data;
  }

  List<Object?> get props => [name, id];
}

class Documents {
  final String? id;
  final String? type;
  final List<FileData>? files;
  final bool? isActive;
  bool isExpanded = false;

  Documents(
      {this.id,
      this.type,
      this.files,
      this.isActive,
      required this.isExpanded});

  factory Documents.fromJson(Map<String, dynamic> json) {
    return Documents(
        id: json['_id'],
        type: json["documentType"],
        files: json['fileData'] != null
            ? json['fileData']!.map<FileData>((data) => FileData.fromJson(data)).toList()
            : [],
        isActive: (json['isActive'] == 1),
        isExpanded: false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['documentType'] = type;
    data['fileData'] = files;
    data['isActive'] = isActive;
    return data;
  }

  List<Object?> get props => [id, type, files, isActive];
}

class FileData {
  final String? file;
  final String? email;
  final String? date;

  FileData({this.file, this.email, this.date});

  factory FileData.fromJson(Map<String, dynamic> json) {
    return FileData(
        file: json['file'],
        email: json["email"],
        date: json["date"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    data['email'] = email;
    data['date'] = date;
    return data;
  }

  List<Object?> get props => [file, email, date];
}
