class RecordedVideoModel {
  bool? status;
  List<RecordedVideoDataModel>? data;
  String? msg;

  RecordedVideoModel({this.status, this.data, this.msg});

  RecordedVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <RecordedVideoDataModel>[];
      json['data'].forEach((v) {
        data!.add(new RecordedVideoDataModel.fromJson(v));
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

class RecordedVideoDataModel {
  String? lectureName;
  List<Listofvideos>? listofvideos;

  RecordedVideoDataModel({this.lectureName, this.listofvideos});

  RecordedVideoDataModel.fromJson(Map<String, dynamic> json) {
    lectureName = json['LectureName'];
    if (json['Listofvideos'] != null) {
      listofvideos = <Listofvideos>[];
      json['Listofvideos'].forEach((v) {
        listofvideos!.add(new Listofvideos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LectureName'] = this.lectureName;
    if (this.listofvideos != null) {
      data['Listofvideos'] = this.listofvideos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Listofvideos {
  String? sId;
  String? title;
  FileUrl? fileUrl;
  String? batchId;
  String? language;
  LectureId? lectureId;
  bool? isActive;
  String? createdAt;
  bool? isVerfied;

  Listofvideos(
      {this.sId,
      this.title,
      this.fileUrl,
      this.batchId,
      this.language,
      this.lectureId,
      this.isActive,
      this.createdAt,
      this.isVerfied});

  Listofvideos.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    fileUrl = json['file_url'] != null
        ? new FileUrl.fromJson(json['file_url'])
        : null;
    batchId = json['batch_id'];
    language = json['language'];
    lectureId = json['lecture_id'] != null
        ? new LectureId.fromJson(json['lecture_id'])
        : null;
    isActive = json['is_active'];
    createdAt = json['created_at'];
    isVerfied = json['is_verfied'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    if (this.fileUrl != null) {
      data['file_url'] = this.fileUrl!.toJson();
    }
    data['batch_id'] = this.batchId;
    data['language'] = this.language;
    if (this.lectureId != null) {
      data['lecture_id'] = this.lectureId!.toJson();
    }
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['is_verfied'] = this.isVerfied;
    return data;
  }
}

class FileUrl {
  String? fileLoc;
  String? fileName;
  String? fileSize;

  FileUrl({this.fileLoc, this.fileName, this.fileSize});

  FileUrl.fromJson(Map<String, dynamic> json) {
    fileLoc = json['fileLoc'];
    fileName = json['fileName'];
    fileSize = json['fileSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileLoc'] = this.fileLoc;
    data['fileName'] = this.fileName;
    data['fileSize'] = this.fileSize;
    return data;
  }
}

class LectureId {
  String? sId;
  String? lectureTitle;

  LectureId({this.sId, this.lectureTitle});

  LectureId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lectureTitle = json['lecture_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['lecture_title'] = this.lectureTitle;
    return data;
  }
}
