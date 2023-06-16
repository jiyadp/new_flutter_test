class LoginModel {
  final bool? success;
  final String? message;
  final LoginData? data;

  const LoginModel({this.success, this.message, this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      success: json['success'],
      message: json['message'],
      data: LoginData.fromJson(json['data']));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}

class LoginData {
  final String? id;
  final String? fullName;
  final String? email;
  final String? status;
  final String? role;
  final String? token;
  final String? employeeId;
  final String? profileImage;

  LoginData(
      {this.id,
      this.fullName,
      this.email,
      this.status,
      this.role,
      this.token,
      this.employeeId,
      this.profileImage});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      status: json['status'],
      role: json['role'],
      token: json['token'],
      employeeId: json['employeeId'],
      profileImage: json['profileImage']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['status'] = status;
    data['role'] = role;
    data['token'] = token;
    data['employeeId'] = employeeId;
    data['profileImage'] = profileImage;
    return data;
  }

  List<Object?> get props =>
      [id, fullName, email, status, role, token, employeeId];
}
