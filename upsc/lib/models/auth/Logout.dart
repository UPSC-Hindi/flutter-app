class Logout {
  bool? status;
  Null data;
  String? msg;

  Logout({this.status, this.data, this.msg});

  Logout.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['data'] = this.data;
    data['msg'] = msg;
    return data;
  }
}
