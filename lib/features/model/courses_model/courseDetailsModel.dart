
import 'dart:convert';

CoursesDetailsModel coursesDetailsModelFromJson(String str) => CoursesDetailsModel.fromJson(json.decode(str));

String coursesDetailsModelToJson(CoursesDetailsModel data) => json.encode(data.toJson());

class CoursesDetailsModel {
  CoursesDetailsModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  final bool status;
  final CoursesDetailsDataModel data;
  final String msg;

  factory CoursesDetailsModel.fromJson(Map<String, dynamic> json) => CoursesDetailsModel(
    status: json["status"],
    data: CoursesDetailsDataModel.fromJson(json["data"]),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "msg": msg,
  };
}

class CoursesDetailsDataModel {
  CoursesDetailsDataModel({
    required this.batchDetails,
    required this.noOfVideos,
    required this.noofNotes,
  });

  final BatchDetails batchDetails;
  final int noOfVideos;
  final int noofNotes;

  factory CoursesDetailsDataModel.fromJson(Map<String, dynamic> json) => CoursesDetailsDataModel(
    batchDetails: BatchDetails.fromJson(json["batchDetails"]),
    noOfVideos: json["NoOfVideos"],
    noofNotes: json["NoofNotes"],
  );

  Map<String, dynamic> toJson() => {
    "batchDetails": batchDetails.toJson(),
    "NoOfVideos": noOfVideos,
    "NoofNotes": noofNotes,
  };
}

class BatchDetails {
  BatchDetails({
    required this.id,
    required this.batchName,
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
    required this.stream,
    required this.remark,
    required this.demoVideo,
    required this.validity,
    required this.isActive,
    required this.courseReview,
    required this.createdAt,
  });

  final String id;
  final String batchName;
  final String examType;
  final List<String> student;
  final List<Subject> subject;
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
  final String stream;
  final String remark;
  final List<Banner> demoVideo;
  final String validity;
  final bool isActive;
  final String courseReview;
  final String createdAt;

  factory BatchDetails.fromJson(Map<String, dynamic> json) => BatchDetails(
    id: json["_id"],
    batchName: json["batch_name"],
    examType: json["exam_type"],
    student: List<String>.from(json["student"].map((x) => x)),
    subject: List<Subject>.from(json["subject"].map((x) => Subject.fromJson(x))),
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
    stream: json["stream"],
    remark: json["remark"],
    demoVideo: List<Banner>.from(json["demoVideo"].map((x) => Banner.fromJson(x))),
    validity: json["validity"],
    isActive: json["is_active"],
    courseReview: json["course_review"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "batch_name": batchName,
    "exam_type": examType,
    "student": List<dynamic>.from(student.map((x) => x)),
    "subject": List<dynamic>.from(subject.map((x) => x.toJson())),
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
    "stream": stream,
    "remark": remark,
    "demoVideo": List<dynamic>.from(demoVideo.map((x) => x.toJson())),
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
    required this.bannerfileType,
    required this.demoVideofileType,
  });

  final String fileLoc;
  final String fileName;
  final String fileSize;
  final dynamic bannerfileType;
  final dynamic demoVideofileType;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    fileLoc: json["fileLoc"],
    fileName: json["fileName"],
    fileSize: json["fileSize"],
    bannerfileType: json["bannerfileType"],
    demoVideofileType: json["DemoVideofileType"],
  );

  Map<String, dynamic> toJson() => {
    "fileLoc": fileLoc,
    "fileName": fileName,
    "fileSize": fileSize,
    "bannerfileType": bannerfileType,
    "DemoVideofileType": demoVideofileType,
  };
}

class Subject {
  Subject({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
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