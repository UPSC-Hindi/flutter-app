
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

  factory BatchDetails.fromJson(Map<String, dynamic> json) => BatchDetails(
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
