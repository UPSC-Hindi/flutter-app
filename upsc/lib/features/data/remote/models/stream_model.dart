class StreamModel {
  StreamModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  final bool status;
  final List<StreamDataModel> data;
  final String msg;

  factory StreamModel.fromJson(Map<String, dynamic> json) => StreamModel(
        status: json["status"],
        data: List<StreamDataModel>.from(
            json["data"].map((x) => StreamDataModel.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "msg": msg,
      };
}

class StreamDataModel {
  StreamDataModel({
    required this.id,
    required this.title,
    required this.isActive,
    required this.createdAt,
    required this.type,
    required this.user,
    required this.v,
  });

  final String id;
  final String title;
  final bool isActive;
  final String createdAt;
  final String type;
  final String user;
  final int v;

  factory StreamDataModel.fromJson(Map<String, dynamic> json) =>
      StreamDataModel(
        id: json["_id"],
        title: json["title"],
        isActive: json["is_active"],
        createdAt: json["created_at"],
        type: json["type"],
        user: json["user"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "is_active": isActive,
        "created_at": createdAt,
        "type": type,
        "user": user,
        "__v": v,
      };
}
