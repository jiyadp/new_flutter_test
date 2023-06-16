class CertificatesModel {
  final bool? success;
  final String? message;
  final List<Certificates>? data;

  const CertificatesModel({this.success, this.message, this.data});

  factory CertificatesModel.fromJson(Map<String, dynamic> json) =>
      CertificatesModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null
            ? json['data']!
                .map<Certificates>((data) => Certificates.fromJson(data))
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

class Certificates {
  final String? id;
  final String? title;
  final String? type;
  final String? startDate;
  final String? endDate;
  final String? url;

  const Certificates(
      {this.id, this.title, this.type, this.startDate, this.endDate, this.url});

  factory Certificates.fromJson(Map<String, dynamic> json) {
    return Certificates(
        id: json['_id'],
        title: json["name"],
        type: json['type'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        url: json['url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = title;
    data['type'] = type;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['url'] = url;
    return data;
  }

  List<Object?> get props => [id, title, type, startDate, endDate, url];
}
