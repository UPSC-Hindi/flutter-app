
class CourseModel {
  CourseModel({
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
  final Category category;
  final String examType;
  final String subject;
  final List<dynamic> teacher;
  final DateTime startingDate;
  final DateTime endingDate;
  final String mode;
  final String materials;
  final String charges;
  final String discount;
  final String description;
  final String banner;
  final String remark;
  final String validity;
  final String courseReview;
  final String createdAt;
  final int v;

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    id: json["_id"],
    user: json["user"],
    batchName: json["batch_name"],
    category: Category.fromJson(json["category"]),
    examType: json["exam_type"],
    subject: json["subject"],
    teacher: List<dynamic>.from(json["teacher"].map((x) => x)),
    startingDate: DateTime.parse(json["starting_date"]),
    endingDate: DateTime.parse(json["ending_date"]),
    mode: json["mode"],
    materials: json["materials"],
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
    "category": category.toJson(),
    "exam_type": examType,
    "subject": subject,
    "teacher": List<dynamic>.from(teacher.map((x) => x)),
    "starting_date": "${startingDate.year.toString().padLeft(4, '0')}-${startingDate.month.toString().padLeft(2, '0')}-${startingDate.day.toString().padLeft(2, '0')}",
    "ending_date": "${endingDate.year.toString().padLeft(4, '0')}-${endingDate.month.toString().padLeft(2, '0')}-${endingDate.day.toString().padLeft(2, '0')}",
    "mode": mode,
    "materials": materials,
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

class Category {
  Category({
    required this.id,
    required this.title,
    required this.isActive,
    required this.createdAt,
    required this.user,
    required this.v,
  });

  final String id;
  final String title;
  final bool isActive;
  final String createdAt;
  final String user;
  final int v;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    title: json["title"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    user: json["user"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "is_active": isActive,
    "created_at": createdAt,
    "user": user,
    "__v": v,
  };
}
