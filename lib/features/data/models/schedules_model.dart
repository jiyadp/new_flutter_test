class SchedulesModel {
  final bool? success;
  final String? message;
  List<SchedulesData>? data;

  SchedulesModel({this.success, this.message, this.data});

  factory SchedulesModel.fromJson(Map<String, dynamic> json) => SchedulesModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null
            ? json['data']!
                .map<SchedulesData>((data) => SchedulesData.fromJson(data))
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

class SchedulesData {
  final String? id;
  final String? scheduleNo;
  final String? operator;
  final String? startDate;
  final String? endDate;
  final Site? site;

  const SchedulesData(
      {this.id,
      this.scheduleNo,
      this.operator,
      this.startDate,
      this.endDate,
      this.site});

  factory SchedulesData.fromJson(Map<String, dynamic> json) {
    return SchedulesData(
        id: json['_id'],
        scheduleNo: json['scheduleNo'],
        operator: json['operator'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        site: Site.fromJson(json['site']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['scheduleNo'] = scheduleNo;
    data['operator'] = operator;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['site'] = site;
    return data;
  }

  List<Object?> get props => [id, scheduleNo,operator,startDate,endDate,site];
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

