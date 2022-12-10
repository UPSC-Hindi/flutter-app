
class MyCoursesModel {
  MyCoursesModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  final bool status;
  final List<MyCoursesDataModel> data;
  final String msg;

  factory MyCoursesModel.fromJson(Map<String, dynamic> json) => MyCoursesModel(
    status: json["status"],
    data: List<MyCoursesDataModel>.from(json["data"].map((x) => MyCoursesDataModel.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class MyCoursesDataModel {
  MyCoursesDataModel({
    required this.myBatchId,
    required this.isActive,
    required this.lectureDetails,
    required this.batchDetails,
  });

  final String myBatchId;
  final bool isActive;
  final List<LectureDetail> lectureDetails;
  final BatchDetails batchDetails;

  factory MyCoursesDataModel.fromJson(Map<String, dynamic> json) => MyCoursesDataModel(
    myBatchId: json["MyBatch_id"],
    isActive: json["is_active"],
    lectureDetails: List<LectureDetail>.from(json["lectureDetails"].map((x) => LectureDetail.fromJson(x))),
    batchDetails: BatchDetails.fromJson(json["batchDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "MyBatch_id": myBatchId,
    "is_active": isActive,
    "lectureDetails": List<dynamic>.from(lectureDetails.map((x) => x.toJson())),
    "batchDetails": batchDetails.toJson(),
  };
}

class BatchDetails {
  BatchDetails({
    required this.id,
    required this.user,
    required this.batchName,
    required this.category,
    required this.examType,
    required this.subject,
    required this.teacher,
    required this.startingDate,
    required this.endingDate,
    required this.mode,
    required this.materials,
    required this.language,
    required this.description,
    required this.banner,
    required this.remark,
    required this.demoVideo,
    required this.validity,
    required this.isActive,
    required this.courseReview,
  });

  final String id;
  final String user;
  final String batchName;
  final Category category;
  final String examType;
  final List<Category> subject;
  final List<Teacher> teacher;
  final DateTime startingDate;
  final DateTime endingDate;
  final String mode;
  final String materials;
  final String language;
  final String description;
  final List<MyCoursesBanner> banner;
  final String remark;
  final List<MyCoursesBanner> demoVideo;
  final String validity;
  final bool isActive;
  final String courseReview;

  factory BatchDetails.fromJson(Map<String, dynamic> json) => BatchDetails(
    id: json["_id"],
    user: json["user"],
    batchName: json["batch_name"],
    category: Category.fromJson(json["category"]),
    examType: json["exam_type"],
    subject: List<Category>.from(json["subject"].map((x) => Category.fromJson(x))),
    teacher: List<Teacher>.from(json["teacher"].map((x) => Teacher.fromJson(x))),
    startingDate: DateTime.parse(json["starting_date"]),
    endingDate: DateTime.parse(json["ending_date"]),
    mode: json["mode"],
    materials: json["materials"],
    language: json["language"],
    description: json["description"],
    banner: List<MyCoursesBanner>.from(json["banner"].map((x) => MyCoursesBanner.fromJson(x))),
    remark: json["remark"],
    demoVideo: List<MyCoursesBanner>.from(json["demoVideo"].map((x) => MyCoursesBanner.fromJson(x))),
    validity: json["validity"],
    isActive: json["is_active"],
    courseReview: json["course_review"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "batch_name": batchName,
    "category": category.toJson(),
    "exam_type": examType,
    "subject": List<dynamic>.from(subject.map((x) => x.toJson())),
    "teacher": List<dynamic>.from(teacher.map((x) => x.toJson())),
    "starting_date": "${startingDate.year.toString().padLeft(4, '0')}-${startingDate.month.toString().padLeft(2, '0')}-${startingDate.day.toString().padLeft(2, '0')}",
    "ending_date": "${endingDate.year.toString().padLeft(4, '0')}-${endingDate.month.toString().padLeft(2, '0')}-${endingDate.day.toString().padLeft(2, '0')}",
    "mode": mode,
    "materials": materials,
    "language": language,
    "description": description,
    "banner": List<dynamic>.from(banner.map((x) => x.toJson())),
    "remark": remark,
    "demoVideo": List<dynamic>.from(demoVideo.map((x) => x.toJson())),
    "validity": validity,
    "is_active": isActive,
    "course_review": courseReview,
  };
}

class MyCoursesBanner {
  MyCoursesBanner({
    required this.fileLoc,
    required this.fileName,
    required this.fileSize,
    required this.bannerfileType,
  });

  final String fileLoc;
  final String fileName;
  final String fileSize;
  final String bannerfileType;

  factory MyCoursesBanner.fromJson(Map<String, dynamic> json) => MyCoursesBanner(
    fileLoc: json["fileLoc"],
    fileName: json["fileName"],
    fileSize: json["fileSize"],
    bannerfileType: json["bannerfileType"] == null ? null : json["bannerfileType"],
  );

  Map<String, dynamic> toJson() => {
    "fileLoc": fileLoc,
    "fileName": fileName,
    "fileSize": fileSize,
    "bannerfileType": bannerfileType == null ? null : bannerfileType,
  };
}

class Category {
  Category({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
  };
}

class Teacher {
  Teacher({
    required this.id,
    required this.fullName,
    required this.profilePhoto,
  });

  final String id;
  final String fullName;
  final String profilePhoto;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    id: json["_id"],
    fullName: json["FullName"],
    profilePhoto: json["profilePhoto"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "FullName": fullName,
    "profilePhoto": profilePhoto,
  };
}

class LectureDetail {
  LectureDetail({
    required this.id,
    required this.lectureTitle,
    required this.description,
    required this.teacher,
    required this.subject,
    required this.startingDate,
    required this.endingDate,
    required this.material,
    required this.language,
  });

  final String id;
  final String lectureTitle;
  final String description;
  final List<Teacher> teacher;
  final Subject subject;
  final String startingDate;
  final String endingDate;
  final MyCoursesBanner material;
  final String language;

  factory LectureDetail.fromJson(Map<String, dynamic> json) => LectureDetail(
    id: json["_id"],
    lectureTitle: json["lecture_title"],
    description: json["description"],
    teacher: List<Teacher>.from(json["teacher"].map((x) => Teacher.fromJson(x))),
    subject: Subject.fromJson(json["subject"]),
    startingDate: json["starting_date"],
    endingDate: json["ending_date"],
    material: MyCoursesBanner.fromJson(json["material"]),
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "lecture_title": lectureTitle,
    "description": description,
    "teacher": List<dynamic>.from(teacher.map((x) => x.toJson())),
    "subject": subject.toJson(),
    "starting_date": startingDate,
    "ending_date": endingDate,
    "material": material.toJson(),
    "language": language,
  };
}

class Subject {
  Subject({
    required this.id,
    required this.title,
    required this.isActive,
    required this.user,
    required this.v,
  });

  final String id;
  final String title;
  final String isActive;
  final String user;
  final int v;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["_id"],
    title: json["title"],
    isActive: json["is_active"],
    user: json["user"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "is_active": isActive,
    "user": user,
    "__v": v,
  };
}
