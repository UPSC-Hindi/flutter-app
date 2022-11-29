
class RecordedVideoModel {
  RecordedVideoModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  final bool status;
  final List<RecordedVideoDataModel> data;
  final String msg;

  factory RecordedVideoModel.fromJson(Map<String, dynamic> json) => RecordedVideoModel(
    status: json["status"],
    data: List<RecordedVideoDataModel>.from(json["data"].map((x) => RecordedVideoDataModel.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class RecordedVideoDataModel {
  RecordedVideoDataModel({
    required this.id,
    required this.user,
    required this.title,
    required this.fileUrl,
    required this.batchId,
    required this.language,
    required this.lectureId,
    required this.isActive,
    required this.createdAt,
    required this.isVerfied,
    required this.v,
  });

  final String id;
  final String user;
  final String title;
  final String fileUrl;
  final BatchId batchId;
  final String language;
  final LectureId lectureId;
  final bool isActive;
  final String createdAt;
  final bool isVerfied;
  final int v;

  factory RecordedVideoDataModel.fromJson(Map<String, dynamic> json) => RecordedVideoDataModel(
    id: json["_id"],
    user: json["user"],
    title: json["title"],
    fileUrl: json["file_url"],
    batchId: BatchId.fromJson(json["batch_id"]),
    language: json["language"],
    lectureId: LectureId.fromJson(json["lecture_id"]),
    isActive: json["is_active"],
    createdAt: json["created_at"],
    isVerfied: json["is_verfied"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "title": title,
    "file_url": fileUrl,
    "batch_id": batchId.toJson(),
    "language": language,
    "lecture_id": lectureId.toJson(),
    "is_active": isActive,
    "created_at": createdAt,
    "is_verfied": isVerfied,
    "__v": v,
  };
}

class BatchId {
  BatchId({
    required this.id,
    required this.user,
    required this.batchName,
    required this.category,
    required this.examType,
    required this.student,
    required this.subject,
    required this.teacher,
    required this.startingDate,
    required this.endingDate,
    required this.mode,
    required this.materials,
    required this.language,
    required this.charges,
    required this.discount,
    required this.description,
    required this.remark,
    required this.validity,
    required this.isActive,
    required this.courseReview,
    required this.createdAt,
    required this.v,
  });

  final String id;
  final String user;
  final String batchName;
  final String category;
  final String examType;
  final List<String> student;
  final String subject;
  final List<String> teacher;
  final DateTime startingDate;
  final DateTime endingDate;
  final String mode;
  final String materials;
  final String language;
  final String charges;
  final String discount;
  final String description;
  final String remark;
  final String validity;
  final bool isActive;
  final String courseReview;
  final String createdAt;
  final int v;

  factory BatchId.fromJson(Map<String, dynamic> json) => BatchId(
    id: json["_id"],
    user: json["user"],
    batchName: json["batch_name"],
    category: json["category"],
    examType: json["exam_type"],
    student: List<String>.from(json["student"].map((x) => x)),
    subject: json["subject"],
    teacher: List<String>.from(json["teacher"].map((x) => x)),
    startingDate: DateTime.parse(json["starting_date"]),
    endingDate: DateTime.parse(json["ending_date"]),
    mode: json["mode"],
    materials: json["materials"],
    language: json["language"],
    charges: json["charges"],
    discount: json["discount"],
    description: json["description"],
    remark: json["remark"],
    validity: json["validity"],
    isActive: json["is_active"],
    courseReview: json["course_review"],
    createdAt: json["created_at"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "batch_name": batchName,
    "category": category,
    "exam_type": examType,
    "student": List<dynamic>.from(student.map((x) => x)),
    "subject": subject,
    "teacher": List<dynamic>.from(teacher.map((x) => x)),
    "starting_date": "${startingDate.year.toString().padLeft(4, '0')}-${startingDate.month.toString().padLeft(2, '0')}-${startingDate.day.toString().padLeft(2, '0')}",
    "ending_date": "${endingDate.year.toString().padLeft(4, '0')}-${endingDate.month.toString().padLeft(2, '0')}-${endingDate.day.toString().padLeft(2, '0')}",
    "mode": mode,
    "materials": materials,
    "language": language,
    "charges": charges,
    "discount": discount,
    "description": description,
    "remark": remark,
    "validity": validity,
    "is_active": isActive,
    "course_review": courseReview,
    "created_at": createdAt,
    "__v": v,
  };
}

class LectureId {
  LectureId({
    required this.id,
    required this.userAdmin,
    required this.batch,
    required this.lectureTitle,
    required this.description,
    required this.subject,
    required this.link,
    required this.liveOrRecorded,
    required this.startingDate,
    required this.endingDate,
    required this.createdAt,
    required this.language,
    required this.v,
  });

  final String id;
  final String userAdmin;
  final String batch;
  final String lectureTitle;
  final String description;
  final String subject;
  final String link;
  final String liveOrRecorded;
  final String startingDate;
  final String endingDate;
  final String createdAt;
  final String language;
  final int v;

  factory LectureId.fromJson(Map<String, dynamic> json) => LectureId(
    id: json["_id"],
    userAdmin: json["user_admin"],
    batch: json["batch"],
    lectureTitle: json["lecture_title"],
    description: json["description"],
    subject: json["subject"],
    link: json["link"],
    liveOrRecorded: json["LiveOrRecorded"],
    startingDate: json["starting_date"],
    endingDate: json["ending_date"],
    createdAt: json["created_at"],
    language: json["language"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user_admin": userAdmin,
    "batch": batch,
    "lecture_title": lectureTitle,
    "description": description,
    "subject": subject,
    "link": link,
    "LiveOrRecorded": liveOrRecorded,
    "starting_date": startingDate,
    "ending_date": endingDate,
    "created_at": createdAt,
    "language": language,
    "__v": v,
  };
}
