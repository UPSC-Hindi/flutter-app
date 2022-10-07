// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  CourseModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  final bool status;
  final List<CourseDataModel> data;
  final String msg;

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    status: json["status"],
    data: List<CourseDataModel>.from(json["data"].map((x) => CourseDataModel.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class CourseDataModel {
  CourseDataModel({
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
  final List<Student> student;
  final String subject;
  final List<Teacher> teacher;
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

  factory CourseDataModel.fromJson(Map<String, dynamic> json) => CourseDataModel(
    id: json["_id"],
    user: json["user"],
    batchName: json["batch_name"],
    category: json["category"],
    examType: json["exam_type"],
    student: List<Student>.from(json["student"].map((x) => Student.fromJson(x))),
    subject: json["subject"],
    teacher: List<Teacher>.from(json["teacher"].map((x) => Teacher.fromJson(x))),
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
    "student": List<dynamic>.from(student.map((x) => x.toJson())),
    "subject": subject,
    "teacher": List<dynamic>.from(teacher.map((x) => x.toJson())),
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

class Student {
  Student({
    required this.id,
    required this.username,
    required this.userId,
    required this.fullName,
    required this.password,
    required this.email,
    required this.createdAt,
    required this.refreshToken,
    required this.mobileNumber,
    required this.emailVerificationOtp,
    required this.mobileNumberVerificationOtp,
    required this.otpcreatedDate,
    required this.loginTrack,
    required this.v,
    required this.mobileNumberVerified,
    required this.language,
  });

  final String id;
  final String username;
  final String userId;
  final String fullName;
  final String password;
  final String email;
  final DateTime createdAt;
  final String refreshToken;
  final String mobileNumber;
  final int emailVerificationOtp;
  final int mobileNumberVerificationOtp;
  final String otpcreatedDate;
  final String loginTrack;
  final int v;
  final bool mobileNumberVerified;
  final String language;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["_id"],
    username: json["username"],
    userId: json["userId"],
    fullName: json["FullName"],
    password: json["password"],
    email: json["email"],
    createdAt: DateTime.parse(json["created_at"]),
    refreshToken: json["RefreshToken"],
    mobileNumber: json["mobileNumber"],
    emailVerificationOtp: json["emailVerificationOTP"],
    mobileNumberVerificationOtp: json["mobileNumberVerificationOTP"],
    otpcreatedDate: json["otpcreatedDate"],
    loginTrack: json["LoginTrack"],
    v: json["__v"],
    mobileNumberVerified: json["mobileNumberVerified"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "userId": userId,
    "FullName": fullName,
    "password": password,
    "email": email,
    "created_at": createdAt.toIso8601String(),
    "RefreshToken": refreshToken,
    "mobileNumber": mobileNumber,
    "emailVerificationOTP": emailVerificationOtp,
    "mobileNumberVerificationOTP": mobileNumberVerificationOtp,
    "otpcreatedDate": otpcreatedDate,
    "LoginTrack": loginTrack,
    "__v": v,
    "mobileNumberVerified": mobileNumberVerified,
    "language": language,
  };
}

class Teacher {
  Teacher({
    required this.id,
    required this.fullName,
    required this.role,
    required this.userId,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.v,
  });

  final String id;
  final String fullName;
  final String role;
  final String userId;
  final int mobileNumber;
  final String email;
  final String password;
  final DateTime createdAt;
  final int v;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    id: json["_id"],
    fullName: json["FullName"],
    role: json["Role"],
    userId: json["userId"],
    mobileNumber: json["mobileNumber"],
    email: json["email"],
    password: json["password"],
    createdAt: DateTime.parse(json["created_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "FullName": fullName,
    "Role": role,
    "userId": userId,
    "mobileNumber": mobileNumber,
    "email": email,
    "password": password,
    "created_at": createdAt.toIso8601String(),
    "__v": v,
  };
}
