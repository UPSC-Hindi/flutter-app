class postUserMobileNumber {
  bool? status;
  List<Data>? data;
  String? msg;

  postUserMobileNumber({this.status, this.data, this.msg});

  postUserMobileNumber.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
