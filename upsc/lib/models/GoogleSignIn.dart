class GoogleSignIn {
  bool? status;
  Data? data;
  String? msg;

  GoogleSignIn({this.status, this.data, this.msg});

  GoogleSignIn.fromJson(Map<String, dynamic> json) {
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
  String? token;
  String? email;
  String? username;

  Data({this.token, this.email, this.username});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    data['email'] = email;
    data['username'] = username;
    return data;
  }
}
