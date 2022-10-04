class VerifyMobileNumber {
  bool? status;
  Data? data;
  String? msg;

  VerifyMobileNumber({this.status, this.data, this.msg});

  VerifyMobileNumber.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;
  String? username;

  Data({this.accessToken, this.username});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['access_token'] = accessToken;
    data['username'] = username;
    return data;
  }
}
