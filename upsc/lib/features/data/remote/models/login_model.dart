
class LoginModel {
  LoginModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  final bool status;
  final LoginDataModel data;
  final String msg;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    data: LoginDataModel.fromJson(json["data"]),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "msg": msg,
  };
}

class LoginDataModel {
  LoginDataModel({
    required this.refreshTokenAuth,
    required this.accessToken,
    required this.language,
    required this.stream,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.userId,
    required this.fullName,
    required this.profilePhoto,
    required this.address,
    required this.mobileVerified,
  });

  final String refreshTokenAuth;
  final String accessToken;
  final String language;
  final List<String> stream;
  final String username;
  final String email;
  final String phoneNumber;
  final String userId;
  final String fullName;
  final String profilePhoto;
  final String address;
  final bool mobileVerified;

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
    refreshTokenAuth: json["RefreshTokenAuth"],
    accessToken: json["accessToken"],
    language: json["language"],
    stream: List<String>.from(json["stream"].map((x) => x)),
    username: json["username"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    userId: json["userID"],
    fullName: json["FullName"],
    profilePhoto: json["profilePhoto"],
    address: json["Address"],
    mobileVerified: json["mobileVerified"],
  );

  Map<String, dynamic> toJson() => {
    "RefreshTokenAuth": refreshTokenAuth,
    "accessToken": accessToken,
    "language": language,
    "stream": List<dynamic>.from(stream.map((x) => x)),
    "username": username,
    "email": email,
    "phoneNumber": phoneNumber,
    "userID": userId,
    "FullName": fullName,
    "profilePhoto": profilePhoto,
    "Address": address,
    "mobileVerified": mobileVerified,
  };
}
