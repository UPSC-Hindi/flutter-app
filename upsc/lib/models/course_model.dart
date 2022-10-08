class CourseModel {
  bool? status;
  List<Data>? data;
  String? msg;

  CourseModel({this.status, this.data, this.msg});

  CourseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  String? sId;
  String? user;
  String? batchName;
  Category? category;
  String? examType;
  List<Student>? student;
  String? subject;
  List<Teacher>? teacher;
  DateTime? startingDate;
  DateTime? endingDate;
  String? mode;
  String? materials;
  String? language;
  String? charges;
  String? discount;
  String? description;
  String? banner;
  String? remark;
  String? validity;
  String? courseReview;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
      this.user,
      this.batchName,
      this.category,
      this.examType,
      this.student,
      this.subject,
      this.teacher,
      this.startingDate,
      this.endingDate,
      this.mode,
      this.materials,
      this.language,
      this.charges,
      this.discount,
      this.description,
      this.banner,
      this.remark,
      this.validity,
      this.courseReview,
      this.createdAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    batchName = json['batch_name'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    examType = json['exam_type'];
    if (json['student'] != null) {
      student = <Student>[];
      json['student'].forEach((v) {
        student!.add(new Student.fromJson(v));
      });
    }
    subject = json['subject'];
    if (json['teacher'] != null) {
      teacher = <Teacher>[];
      json['teacher'].forEach((v) {
        teacher!.add(new Teacher.fromJson(v));
      });
    }
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    mode = json['mode'];
    materials = json['materials'];
    language = json['language'];
    charges = json['charges'];
    discount = json['discount'];
    description = json['description'];
    banner = json['banner'];
    remark = json['remark'];
    validity = json['validity'];
    courseReview = json['course_review'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['batch_name'] = this.batchName;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['exam_type'] = this.examType;
    if (this.student != null) {
      data['student'] = this.student!.map((v) => v.toJson()).toList();
    }
    data['subject'] = this.subject;
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.map((v) => v.toJson()).toList();
    }
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    data['mode'] = this.mode;
    data['materials'] = this.materials;
    data['language'] = this.language;
    data['charges'] = this.charges;
    data['discount'] = this.discount;
    data['description'] = this.description;
    data['banner'] = this.banner;
    data['remark'] = this.remark;
    data['validity'] = this.validity;
    data['course_review'] = this.courseReview;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Category {
  String? sId;
  String? title;
  bool? isActive;
  String? createdAt;
  String? type;
  String? user;
  int? iV;

  Category(
      {this.sId,
      this.title,
      this.isActive,
      this.createdAt,
      this.type,
      this.user,
      this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    type = json['type'];
    user = json['user'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['type'] = this.type;
    data['user'] = this.user;
    data['__v'] = this.iV;
    return data;
  }
}

class Student {
  String? sId;
  String? username;
  String? userId;
  String? fullName;
  String? password;
  String? email;
  String? createdAt;
  String? refreshToken;
  String? mobileNumber;
  int? emailVerificationOTP;
  int? mobileNumberVerificationOTP;
  String? otpcreatedDate;
  String? loginTrack;
  int? iV;
  bool? mobileNumberVerified;
  String? language;

  Student(
      {this.sId,
      this.username,
      this.userId,
      this.fullName,
      this.password,
      this.email,
      this.createdAt,
      this.refreshToken,
      this.mobileNumber,
      this.emailVerificationOTP,
      this.mobileNumberVerificationOTP,
      this.otpcreatedDate,
      this.loginTrack,
      this.iV,
      this.mobileNumberVerified,
      this.language});

  Student.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    userId = json['userId'];
    fullName = json['FullName'];
    password = json['password'];
    email = json['email'];
    createdAt = json['created_at'];
    refreshToken = json['RefreshToken'];
    mobileNumber = json['mobileNumber'];
    emailVerificationOTP = json['emailVerificationOTP'];
    mobileNumberVerificationOTP = json['mobileNumberVerificationOTP'];
    otpcreatedDate = json['otpcreatedDate'];
    loginTrack = json['LoginTrack'];
    iV = json['__v'];
    mobileNumberVerified = json['mobileNumberVerified'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['userId'] = this.userId;
    data['FullName'] = this.fullName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['RefreshToken'] = this.refreshToken;
    data['mobileNumber'] = this.mobileNumber;
    data['emailVerificationOTP'] = this.emailVerificationOTP;
    data['mobileNumberVerificationOTP'] = this.mobileNumberVerificationOTP;
    data['otpcreatedDate'] = this.otpcreatedDate;
    data['LoginTrack'] = this.loginTrack;
    data['__v'] = this.iV;
    data['mobileNumberVerified'] = this.mobileNumberVerified;
    data['language'] = this.language;
    return data;
  }
}

class Teacher {
  List<String>? subject;
  String? sId;
  String? fullName;
  String? role;
  String? userId;
  int? mobileNumber;
  String? email;
  String? password;
  String? createdAt;
  int? iV;
  String? qualification;
  bool? isSpecial;

  Teacher(
      {this.subject,
      this.sId,
      this.fullName,
      this.role,
      this.userId,
      this.mobileNumber,
      this.email,
      this.password,
      this.createdAt,
      this.iV,
      this.qualification,
      this.isSpecial});

  Teacher.fromJson(Map<String, dynamic> json) {
    subject = json['subject'].cast<String>();
    sId = json['_id'];
    fullName = json['FullName'];
    role = json['Role'];
    userId = json['userId'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    password = json['password'];
    createdAt = json['created_at'];
    iV = json['__v'];
    qualification = json['qualification'];
    isSpecial = json['is_Special'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['_id'] = this.sId;
    data['FullName'] = this.fullName;
    data['Role'] = this.role;
    data['userId'] = this.userId;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    data['qualification'] = this.qualification;
    data['is_Special'] = this.isSpecial;
    return data;
  }
}
