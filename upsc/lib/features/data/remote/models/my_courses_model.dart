
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
    required this.createdAt,
    required this.amount,
    required this.isPaid,
    required this.isActive,
    required this.lectureDetails,
    required this.batchDetails,
  });

  final String myBatchId;
  final String createdAt;
  final int amount;
  final bool isPaid;
  final bool isActive;
  final List<LectureDetail> lectureDetails;
  final BatchDetails batchDetails;

  factory MyCoursesDataModel.fromJson(Map<String, dynamic> json) => MyCoursesDataModel(
    myBatchId: json["MyBatch_id"],
    createdAt: json["created_at"],
    amount: json["Amount"],
    isPaid: json["is_paid"],
    isActive: json["is_active"],
    lectureDetails: List<LectureDetail>.from(json["lectureDetails"].map((x) => LectureDetail.fromJson(x))),
    batchDetails: BatchDetails.fromJson(json["batchDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "MyBatch_id": myBatchId,
    "created_at": createdAt,
    "Amount": amount,
    "is_paid": isPaid,
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
    required this.banner,
    required this.remark,
    required this.demoVideo,
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
  final List<Student> student;
  final List<String> subject;
  final List<Student> teacher;
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
  final int v;

  factory BatchDetails.fromJson(Map<String, dynamic> json) => BatchDetails(
    id: json["_id"],
    user: json["user"],
    batchName: json["batch_name"],
    category: json["category"],
    examType: json["exam_type"],
    student: List<Student>.from(json["student"].map((x) => Student.fromJson(x))),
    subject: List<String>.from(json["subject"].map((x) => x)),
    teacher: List<Student>.from(json["teacher"].map((x) => Student.fromJson(x))),
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
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "batch_name": batchName,
    "category": category,
    "exam_type": examType,
    "student": List<dynamic>.from(student.map((x) => x.toJson())),
    "subject": List<dynamic>.from(subject.map((x) => x)),
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
    "__v": v,
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

class Student {
  Student({
    required this.id,
    required this.fullName,
    required this.profilePhoto,
  });

  final String id;
  final String fullName;
  final String profilePhoto;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
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
    required this.subject,
    required this.startingDate,
    required this.endingDate,
    required this.material,
    required this.createdAt,
    required this.language,
    required this.v,
  });

  final String id;
  final String lectureTitle;
  final String description;
  final Subject subject;
  final String startingDate;
  final String endingDate;
  final Banner material;
  final String createdAt;
  final String language;
  final int v;

  factory LectureDetail.fromJson(Map<String, dynamic> json) => LectureDetail(
    id: json["_id"],
    lectureTitle: json["lecture_title"],
    description: json["description"],
    subject: Subject.fromJson(json["subject"]),
    startingDate: json["starting_date"],
    endingDate: json["ending_date"],
    material: Banner.fromJson(json["material"]),
    createdAt: json["created_at"],
    language: json["language"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "lecture_title": lectureTitle,
    "description": description,
    "subject": subject.toJson(),
    "starting_date": startingDate,
    "ending_date": endingDate,
    "material": material.toJson(),
    "created_at": createdAt,
    "language": language,
    "__v": v,
  };
}

class Subject {
  Subject({
    required this.title,
  });

  final String title;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
  };
}
