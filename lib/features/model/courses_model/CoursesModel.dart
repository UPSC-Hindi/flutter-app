
class CoursesModel {
  CoursesModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  final bool status;
  final List<CoursesDataModel> data;
  final String msg;

  factory CoursesModel.fromJson(Map<String, dynamic> json) => CoursesModel(
    status: json["status"],
    data: List<CoursesDataModel>.from(json["data"].map((x) => CoursesDataModel.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class CoursesDataModel {
  CoursesDataModel({
    required this.id,
    required this.batchName,
    required this.category,
    required this.examType,
    required this.student,
    required this.teacher,
    required this.startingDate,
    required this.endingDate,
    required this.mode,
    required this.materials,
    required this.language,
    required this.charges,
    required this.discount,
    required this.description,
    required this.banner,
    required this.remark,
    required this.demoVideo,
    required this.validity,
    required this.isActive,
    required this.courseReview,
    required this.createdAt,
  });

  final String id;
  final String batchName;
  final Category category;
  final String examType;
  final List<String> student;
  final List<Teacher> teacher;
  final DateTime startingDate;
  final DateTime endingDate;
  final String mode;
  final String materials;
  final String language;
  final String charges;
  final String discount;
  final String description;
  final List<Banner> banner;
  final String remark;
  final List<dynamic> demoVideo;
  final String validity;
  final bool isActive;
  final String courseReview;
  final String createdAt;

  factory CoursesDataModel.fromJson(Map<String, dynamic> json) => CoursesDataModel(
    id: json["_id"],
    batchName: json["batch_name"],
    category: Category.fromJson(json["category"]),
    examType: json["exam_type"],
    student: List<String>.from(json["student"].map((x) => x)),
    teacher: List<Teacher>.from(json["teacher"].map((x) => Teacher.fromJson(x))),
    startingDate: DateTime.parse(json["starting_date"]),
    endingDate: DateTime.parse(json["ending_date"]),
    mode: json["mode"],
    materials: json["materials"],
    language: json["language"],
    charges: json["charges"],
    discount: json["discount"],
    description: json["description"],
    banner: List<Banner>.from(json["banner"].map((x) => Banner.fromJson(x))),
    remark: json["remark"],
    demoVideo: List<dynamic>.from(json["demoVideo"].map((x) => x)),
    validity: json["validity"],
    isActive: json["is_active"],
    courseReview: json["course_review"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "batch_name": batchName,
    "category": category.toJson(),
    "exam_type": examType,
    "student": List<dynamic>.from(student.map((x) => x)),
    "teacher": List<dynamic>.from(teacher.map((x) => x.toJson())),
    "starting_date": "${startingDate.year.toString().padLeft(4, '0')}-${startingDate.month.toString().padLeft(2, '0')}-${startingDate.day.toString().padLeft(2, '0')}",
    "ending_date": "${endingDate.year.toString().padLeft(4, '0')}-${endingDate.month.toString().padLeft(2, '0')}-${endingDate.day.toString().padLeft(2, '0')}",
    "mode": mode,
    "materials": materials,
    "language": language,
    "charges": charges,
    "discount": discount,
    "description": description,
    "banner": List<dynamic>.from(banner.map((x) => x.toJson())),
    "remark": remark,
    "demoVideo": List<dynamic>.from(demoVideo.map((x) => x)),
    "validity": validity,
    "is_active": isActive,
    "course_review": courseReview,
    "created_at": createdAt,
  };
}

class Banner {
  Banner({
    required this.fileLoc,
    required this.fileName,
    required this.fileSize,
  });

  final String fileLoc;
  final String fileName;
  final String fileSize;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
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

class Category {
  Category({
    required this.id,
    required this.title,
    required this.isActive,
  });

  final String id;
  final String title;
  final bool isActive;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    title: json["title"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "is_active": isActive,
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
