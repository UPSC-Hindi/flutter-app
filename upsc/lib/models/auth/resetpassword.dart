class ResetPassword {
  bool? status;
  String? msg;
  Null? data;

  ResetPassword({this.status, this.msg, this.data});

  ResetPassword.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['msg'] = msg;
    data['data'] = this.data;
    return data;
  }
}
