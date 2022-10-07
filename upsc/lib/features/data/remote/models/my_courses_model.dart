
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
    required this.batchDetails,
  });

  final String myBatchId;
  final DateTime createdAt;
  final int amount;
  final bool isPaid;
  final bool isActive;
  final BatchDetails batchDetails;

  factory MyCoursesDataModel.fromJson(Map<String, dynamic> json) => MyCoursesDataModel(
    myBatchId: json["MyBatch_id"],
    createdAt: DateTime.parse(json["created_at"]),
    amount: json["Amount"],
    isPaid: json["is_paid"],
    isActive: json["is_active"],
    batchDetails: BatchDetails.fromJson(json["batchDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "MyBatch_id": myBatchId,
    "created_at": createdAt.toIso8601String(),
    "Amount": amount,
    "is_paid": isPaid,
    "is_active": isActive,
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
    required this.validity,
    required this.courseReview,
    required this.createdAt,
    required this.v,
  });

  final String id;
  final String user;
  final String batchName;
  final String category;
  final String examType;
  final List<dynamic> student;
  final String subject;
  final List<dynamic> teacher;
  final String startingDate;
  final String endingDate;
  final String mode;
  final String materials;
  final String language;
  final String charges;
  final String discount;
  final String description;
  final String banner;
  final String remark;
  final String validity;
  final String courseReview;
  final String createdAt;
  final int v;

  factory BatchDetails.fromJson(Map<String, dynamic> json) => BatchDetails(
    id: json["_id"],
    user: json["user"],
    batchName: json["batch_name"],
    category: json["category"],
    examType: json["exam_type"],
    student: List<dynamic>.from(json["student"].map((x) => x)),
    subject: json["subject"],
    teacher: List<dynamic>.from(json["teacher"].map((x) => x)),
    startingDate: json["starting_date"],
    endingDate: json["ending_date"],
    mode: json["mode"],
    materials: json["materials"],
    language: json["language"],
    charges: json["charges"],
    discount: json["discount"],
    description: json["description"],
    banner: json["banner"],
    remark: json["remark"],
    validity: json["validity"],
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
    "starting_date": startingDate,
    "ending_date": endingDate,
    "mode": mode,
    "materials": materials,
    "language": language,
    "charges": charges,
    "discount": discount,
    "description": description,
    "banner": banner,
    "remark": remark,
    "validity": validity,
    "course_review": courseReview,
    "created_at": createdAt,
    "__v": v,
  };
}
