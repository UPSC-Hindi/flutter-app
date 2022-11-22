
class DailyNewsModel{
  DailyNewsModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  final bool status;
  final List<DailyNewsDataModel> data;
  final String msg;

  factory DailyNewsModel.fromJson(Map<String, dynamic> json) => DailyNewsModel(
    status: json["status"],
    data: List<DailyNewsDataModel>.from(json["data"].map((x) => DailyNewsDataModel.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class DailyNewsDataModel {
  DailyNewsDataModel({
    required this.id,
    required this.user,
    required this.fileUrl,
    required this.title,
    required this.isActive,
    required this.category,
    required this.language,
    required this.createdAt,
    required this.v,
  });

  final String id;
  final String user;
  final String fileUrl;
  final String title;
  final bool isActive;
  final String category;
  final String language;
  final String createdAt;
  final int v;

  factory DailyNewsDataModel.fromJson(Map<String, dynamic> json) => DailyNewsDataModel(
    id: json["_id"],
    user: json["user"],
    fileUrl: json["file_url"],
    title: json["title"],
    isActive: json["is_active"],
    category: json["category"],
    language: json["language"],
    createdAt: json["created_at"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "file_url": fileUrl,
    "title": title,
    "is_active": isActive,
    "category": category,
    "language": language,
    "created_at": createdAt,
    "__v": v,
  };
}
