
class BatchNotesModel {
  BatchNotesModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  final bool status;
  final List<BatchNotesDataModel> data;
  final String msg;

  factory BatchNotesModel.fromJson(Map<String, dynamic> json) => BatchNotesModel(
    status: json["status"],
    data: List<BatchNotesDataModel>.from(json["data"].map((x) => BatchNotesDataModel.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class BatchNotesDataModel {
  BatchNotesDataModel({
    required this.id,
    required this.user,
    required this.batch,
    required this.lecture,
    required this.title,
    required this.createdAt,
    required this.isActive,
    required this.language,
    required this.uploadFile,
    required this.isVerified,
    required this.v,
  });

  final String id;
  final String user;
  final String batch;
  final String lecture;
  final String title;
  final String createdAt;
  final bool isActive;
  final String language;
  final UploadFile uploadFile;
  final bool isVerified;
  final int v;

  factory BatchNotesDataModel.fromJson(Map<String, dynamic> json) => BatchNotesDataModel(
    id: json["_id"],
    user: json["user"],
    batch: json["batch"],
    lecture: json["lecture"],
    title: json["title"],
    createdAt: json["created_at"],
    isActive: json["is_active"],
    language: json["language"],
    uploadFile: UploadFile.fromJson(json["upload_file"]),
    isVerified: json["is_Verified"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "batch": batch,
    "lecture": lecture,
    "title": title,
    "created_at": createdAt,
    "is_active": isActive,
    "language": language,
    "upload_file": uploadFile.toJson(),
    "is_Verified": isVerified,
    "__v": v,
  };
}

class UploadFile {
  UploadFile({
    required this.fileLoc,
    required this.fileName,
    required this.fileSize,
  });

  final String fileLoc;
  final String fileName;
  final String fileSize;

  factory UploadFile.fromJson(Map<String, dynamic> json) => UploadFile(
    fileLoc: json["fileLoc"],
    fileName: json["fileName"],
    fileSize: json["fileSize"],
  );

  Map<String, dynamic> toJson() => {
    "fileLoc": fileLoc,
    "fileName": fileName,
    "fileSize": fileSize,
  };
}
