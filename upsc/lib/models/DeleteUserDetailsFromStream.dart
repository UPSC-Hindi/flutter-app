class DeleteUserDetailsFromStream {
  bool? status;
  Null data;
  String? msg;

  DeleteUserDetailsFromStream({this.status, this.data, this.msg});

  DeleteUserDetailsFromStream.fromJson(Map<String, dynamic> json) {
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
