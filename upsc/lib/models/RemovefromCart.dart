class RemovefromCart {
  bool? status;
  Null? data;
  String? msg;

  RemovefromCart({this.status, this.data, this.msg});

  RemovefromCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    data['msg'] = this.msg;
    return data;
  }
}
