class Resendotp {
  bool? status;
  Data? data;
  String? msg;

  Resendotp({this.status, this.data, this.msg});

  Resendotp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    return data;
  }
}

class Data {
  String? mobileNumber;
  int? mobileNumberVerificationOTP;

  Data({this.mobileNumber, this.mobileNumberVerificationOTP});

  Data.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    mobileNumberVerificationOTP = json['mobileNumberVerificationOTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mobileNumber'] = mobileNumber;
    data['mobileNumberVerificationOTP'] = mobileNumberVerificationOTP;
    return data;
  }
}
