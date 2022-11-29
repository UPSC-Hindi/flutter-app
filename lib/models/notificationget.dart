class NotificationGet {
  bool? status;
  List<Data>? data;
  String? msg;

  NotificationGet({this.status, this.data, this.msg});

  NotificationGet.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? createdAt;
  String? userId;
  String? status;
  String? message;

  Data({this.title, this.createdAt, this.userId, this.status, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
