class AddToCart {
  bool? status;
  List<Data>? data;
  String? msg;

  AddToCart({this.status, this.data, this.msg});

  AddToCart.fromJson(Map<String, dynamic> json) {
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
  CartDetails? cartDetails;
  BatchDetails? batchDetails;

  Data({this.cartDetails, this.batchDetails});

  Data.fromJson(Map<String, dynamic> json) {
    cartDetails = json['cartDetails'] != null
        ? new CartDetails.fromJson(json['cartDetails'])
        : null;
    batchDetails = json['batchDetails'] != null
        ? new BatchDetails.fromJson(json['batchDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartDetails != null) {
      data['cartDetails'] = this.cartDetails!.toJson();
    }
    if (this.batchDetails != null) {
      data['batchDetails'] = this.batchDetails!.toJson();
    }
    return data;
  }
}

class CartDetails {
  String? createdAt;
  String? user;
  String? batchId;
  String? amount;
  bool? isActive;
  String? sId;

  CartDetails(
      {this.createdAt,
      this.user,
      this.batchId,
      this.amount,
      this.isActive,
      this.sId});

  CartDetails.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    user = json['user'];
    batchId = json['batch_id'];
    amount = json['Amount'];
    isActive = json['is_active'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['user'] = this.user;
    data['batch_id'] = this.batchId;
    data['Amount'] = this.amount;
    data['is_active'] = this.isActive;
    data['_id'] = this.sId;
    return data;
  }
}

class BatchDetails {
  String? sId;
  String? user;
  String? batchName;
  String? category;
  String? examType;
  List<String>? student;
  String? subject;
  List<String>? teacher;
  String? startingDate;
  String? endingDate;
  String? mode;
  String? materials;
  String? language;
  String? charges;
  String? discount;
  String? description;
  String? remark;
  String? validity;
  bool? isActive;
  String? courseReview;
  String? createdAt;
  int? iV;

  BatchDetails(
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
      this.remark,
      this.validity,
      this.isActive,
      this.courseReview,
      this.createdAt,
      this.iV});

  BatchDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    batchName = json['batch_name'];
    category = json['category'];
    examType = json['exam_type'];
    student = json['student'].cast<String>();
    subject = json['subject'];
    teacher = json['teacher'].cast<String>();
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    mode = json['mode'];
    materials = json['materials'];
    language = json['language'];
    charges = json['charges'];
    discount = json['discount'];
    description = json['description'];
    remark = json['remark'];
    validity = json['validity'];
    isActive = json['is_active'];
    courseReview = json['course_review'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['batch_name'] = this.batchName;
    data['category'] = this.category;
    data['exam_type'] = this.examType;
    data['student'] = this.student;
    data['subject'] = this.subject;
    data['teacher'] = this.teacher;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    data['mode'] = this.mode;
    data['materials'] = this.materials;
    data['language'] = this.language;
    data['charges'] = this.charges;
    data['discount'] = this.discount;
    data['description'] = this.description;
    data['remark'] = this.remark;
    data['validity'] = this.validity;
    data['is_active'] = this.isActive;
    data['course_review'] = this.courseReview;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
