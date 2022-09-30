
class VideoModel {
  VideoModel({
    required this.status,
    this.data,
    required this.msg,
  });

  final bool status;
  final List<VideoDataModel>? data;
  final String msg;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    status: json["status"],
    data: List<VideoDataModel>.from(json["data"].map((x) => VideoDataModel.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class VideoDataModel {
  VideoDataModel({
    required this.id,
    required this.user,
    required this.category,
    required this.subject,
    required this.title,
    required this.fileUrl,
    required this.isActive,
    required this.v,
  });

  final String id;
  final String user;
  final String category;
  final String subject;
  final String title;
  final String fileUrl;
  final String isActive;
  final int v;

  factory VideoDataModel.fromJson(Map<String, dynamic> json) => VideoDataModel(
    id: json["_id"],
    user: json["user"],
    category: json["category"],
    subject: json["subject"],
    title: json["title"],
    fileUrl: json["file_url"],
    isActive: json["is_active"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "category": category,
    "subject": subject,
    "title": title,
    "file_url": fileUrl,
    "is_active": isActive,
    "__v": v,
  };


}
