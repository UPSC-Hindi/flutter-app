class ForgetPassword {
  bool? status;
  Data? data;
  String? msg;

  ForgetPassword({this.status, this.data, this.msg});

  ForgetPassword.fromJson(Map<String, dynamic> json) {
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
  int? otpToResetPassword;

  Data({this.otpToResetPassword});

  Data.fromJson(Map<String, dynamic> json) {
    otpToResetPassword = json['otpToResetPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['otpToResetPassword'] = otpToResetPassword;
    return data;
  }
}
