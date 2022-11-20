class NotesModel {
  NotesModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  final bool status;
  final List<NotesDataModel> data;
  final String msg;

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
    status: json["status"],
    data: List<NotesDataModel>.from(json["data"].map((x) => NotesDataModel.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class NotesDataModel {
  NotesDataModel({
    required this.id,
    required this.user,
    required this.title,
    required this.fileUrl,
    required this.notesType,
    required this.isActive,
    required this.language,
    required this.v,
  });

  final String id;
  final String user;
  final String title;
  final String fileUrl;
  final String notesType;
  final bool isActive;
  final String language;
  final int v;

  factory NotesDataModel.fromJson(Map<String, dynamic> json) => NotesDataModel(
    id: json["_id"],
    user: json["user"],
    title: json["title"],
    fileUrl: json["file_url"],
    notesType: json["notes_type"],
    isActive: json["is_active"],
    language: json["language"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "title": title,
    "file_url": fileUrl,
    "notes_type": notesType,
    "is_active": isActive,
    "language": language,
    "__v": v,
  };
}
