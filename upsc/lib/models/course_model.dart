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
        data!.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
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
  bool? isActive;
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
      this.isActive,
      this.courseReview,
      this.createdAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    batchName = json['batch_name'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    examType = json['exam_type'];
    if (json['student'] != null) {
      student = <Student>[];
      json['student'].forEach((v) {
        student!.add(Student.fromJson(v));
      });
    }
    subject = json['subject'];
    if (json['teacher'] != null) {
      teacher = <Teacher>[];
      json['teacher'].forEach((v) {
        teacher!.add(Teacher.fromJson(v));
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
    isActive = json['is_active'];
    courseReview = json['course_review'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    data['batch_name'] = batchName;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['exam_type'] = examType;
    if (student != null) {
      data['student'] = student!.map((v) => v.toJson()).toList();
    }
    data['subject'] = subject;
    if (teacher != null) {
      data['teacher'] = teacher!.map((v) => v.toJson()).toList();
    }
    data['starting_date'] = startingDate;
    data['ending_date'] = endingDate;
    data['mode'] = mode;
    data['materials'] = materials;
    data['language'] = language;
    data['charges'] = charges;
    data['discount'] = discount;
    data['description'] = description;
    data['banner'] = banner;
    data['remark'] = remark;
    data['validity'] = validity;
    data['is_active'] = isActive;
    data['course_review'] = courseReview;
    data['created_at'] = createdAt;
    data['__v'] = iV;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['type'] = type;
    data['user'] = user;
    data['__v'] = iV;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['userId'] = userId;
    data['FullName'] = fullName;
    data['password'] = password;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['RefreshToken'] = refreshToken;
    data['mobileNumber'] = mobileNumber;
    data['emailVerificationOTP'] = emailVerificationOTP;
    data['mobileNumberVerificationOTP'] = mobileNumberVerificationOTP;
    data['otpcreatedDate'] = otpcreatedDate;
    data['LoginTrack'] = loginTrack;
    data['__v'] = iV;
    data['mobileNumberVerified'] = mobileNumberVerified;
    data['language'] = language;
    return data;
  }
}

class Teacher {
  String? sId;
  String? fullName;
  String? role;
  String? userId;
  int? mobileNumber;
  String? email;
  String? password;
  String? createdAt;
  List<String>? subject;
  String? qualification;
  bool? isSpecial;
  int? iV;

  Teacher(
      {this.sId,
      this.fullName,
      this.role,
      this.userId,
      this.mobileNumber,
      this.email,
      this.password,
      this.createdAt,
      this.subject,
      this.qualification,
      this.isSpecial,
      this.iV});

  Teacher.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['FullName'];
    role = json['Role'];
    userId = json['userId'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    password = json['password'];
    createdAt = json['created_at'];
    subject = json['subject'].cast<String>();
    qualification = json['qualification'];
    isSpecial = json['is_Special'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['FullName'] = fullName;
    data['Role'] = role;
    data['userId'] = userId;
    data['mobileNumber'] = mobileNumber;
    data['email'] = email;
    data['password'] = password;
    data['created_at'] = createdAt;
    data['subject'] = subject;
    data['qualification'] = qualification;
    data['is_Special'] = isSpecial;
    data['__v'] = iV;
    return data;
  }
}
