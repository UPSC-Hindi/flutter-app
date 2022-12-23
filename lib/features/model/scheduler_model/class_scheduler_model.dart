class ClassSchedulerModel {
  bool? status;
  List<ClassSchedulerDataModel>? data;
  String? msg;

  ClassSchedulerModel({this.status, this.data, this.msg});

  ClassSchedulerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ClassSchedulerDataModel>[];
      json['data'].forEach((v) {
        data!.add(ClassSchedulerDataModel.fromJson(v));
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

class ClassSchedulerDataModel {
  String? sId;
  String? userAdmin;
  String? batch;
  String? lectureTitle;
  String? description;
  List<String>? teacher;
  String? subject;
  String? link;
  String? liveOrRecorded;
  String? startingDate;
  String? endingDate;
  String? createdAt;
  String? language;
  int? iV;

  ClassSchedulerDataModel(
      {this.sId,
        this.userAdmin,
        this.batch,
        this.lectureTitle,
        this.description,
        this.teacher,
        this.subject,
        this.link,
        this.liveOrRecorded,
        this.startingDate,
        this.endingDate,
        this.createdAt,
        this.language,
        this.iV});

  ClassSchedulerDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userAdmin = json['user_admin'];
    batch = json['batch'];
    lectureTitle = json['lecture_title'];
    description = json['description'];
    teacher = json['teacher'].cast<String>();
    subject = json['subject'];
    link = json['link'];
    liveOrRecorded = json['LiveOrRecorded'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    createdAt = json['created_at'];
    language = json['language'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user_admin'] = userAdmin;
    data['batch'] = batch;
    data['lecture_title'] = lectureTitle;
    data['description'] = description;
    data['teacher'] = teacher;
    data['subject'] = subject;
    data['link'] = link;
    data['LiveOrRecorded'] = liveOrRecorded;
    data['starting_date'] = startingDate;
    data['ending_date'] = endingDate;
    data['created_at'] = createdAt;
    data['language'] = language;
    data['__v'] = iV;
    return data;
  }
}
