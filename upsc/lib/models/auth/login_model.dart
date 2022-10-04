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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    return data;
  }
}

class Data {
  String? accessToken;
  String? language;
  String? username;
  String? email;
  String? phoneNumber;
  String? userID;
  String? fullName;
  bool? mobileVerified;

  Data(
      {this.accessToken,
      this.username,
      this.email,
      this.phoneNumber,
      this.userID,
      this.fullName,
      this.mobileVerified});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    language = json['language'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    userID = json['userID'];
    fullName = json['FullName'];
    mobileVerified = json['mobileVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['accessToken'] = accessToken;
    data['username'] = username;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['userID'] = userID;
    data['FullName'] = fullName;
    data['mobileVerified'] = mobileVerified;
    return data;
  }
}