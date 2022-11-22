class Login {
  bool? status;
  Data? data;
  String? msg;

  Login({this.status, this.data, this.msg});

  Login.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    return data;
  }
}

class Data {
  String? refreshTokenAuth;
  String? accessToken;
  String? language;
  String? username;
  String? email;
  String? phoneNumber;
  String? userID;
  String? fullName;
  String? profilePhoto;
  String? address;
  bool? mobileVerified;

  Data(
      {this.refreshTokenAuth,
      this.accessToken,
      this.language,
      this.username,
      this.email,
      this.phoneNumber,
      this.userID,
      this.fullName,
      this.profilePhoto,
      this.address,
      this.mobileVerified});

  Data.fromJson(Map<String, dynamic> json) {
    refreshTokenAuth = json['RefreshTokenAuth'];
    accessToken = json['accessToken'];
    language = json['language'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    userID = json['userID'];
    fullName = json['FullName'];
    profilePhoto = json['profilePhoto'];
    address = json['Address'];
    mobileVerified = json['mobileVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['RefreshTokenAuth'] = refreshTokenAuth;
    data['accessToken'] = accessToken;
    data['language'] = language;
    data['username'] = username;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['userID'] = userID;
    data['FullName'] = fullName;
    data['profilePhoto'] = profilePhoto;
    data['Address'] = address;
    data['mobileVerified'] = mobileVerified;
    return data;
  }
}
