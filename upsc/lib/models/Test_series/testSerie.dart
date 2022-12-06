class TestSeries {
  bool? status;
  List<TestSeriesData>? data;
  String? msg;

  TestSeries({this.status, this.data, this.msg});

  TestSeries.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TestSeriesData>[];
      json['data'].forEach((v) {
        data!.add(TestSeriesData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class TestSeriesData {
  String? sId;
  String? user;
  String? testseriesName;
  String? examType;
  List<String>? student;
  List<String>? teacher;
  String? startingDate;
  String? charges;
  String? discount;
  List<Banner>? banner;
  String? language;
  String? stream;
  String? remark;
  int? noOfTest;
  String? validity;
  bool? isActive;
  String? createdAt;
  int? iV;

  TestSeriesData(
      {this.sId,
      this.user,
      this.testseriesName,
      this.examType,
      this.student,
      this.teacher,
      this.startingDate,
      this.charges,
      this.discount,
      this.banner,
      this.language,
      this.stream,
      this.remark,
      this.noOfTest,
      this.validity,
      this.isActive,
      this.createdAt,
      this.iV});

  TestSeriesData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    testseriesName = json['testseries_name'];
    examType = json['exam_type'];
    student = json['student'].cast<String>();
    teacher = json['teacher'].cast<String>();
    startingDate = json['starting_date'];
    charges = json['charges'];
    discount = json['discount'];
    if (json['banner'] != null) {
      banner = <Banner>[];
      json['banner'].forEach((v) {
        banner!.add(Banner.fromJson(v));
      });
    }
    language = json['language'];
    stream = json['stream'];
    remark = json['remark'];
    noOfTest = json['no_of_test'];
    validity = json['validity'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['user'] = user;
    data['testseries_name'] = testseriesName;
    data['exam_type'] = examType;
    data['student'] = student;
    data['teacher'] = teacher;
    data['starting_date'] = startingDate;
    data['charges'] = charges;
    data['discount'] = discount;
    if (banner != null) {
      data['banner'] = banner!.map((v) => v.toJson()).toList();
    }
    data['language'] = language;
    data['stream'] = stream;
    data['remark'] = remark;
    data['no_of_test'] = noOfTest;
    data['validity'] = validity;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}

class Banner {
  String? fileLoc;
  String? fileName;
  String? fileSize;

  Banner({this.fileLoc, this.fileName, this.fileSize});

  Banner.fromJson(Map<String, dynamic> json) {
    fileLoc = json['fileLoc'];
    fileName = json['fileName'];
    fileSize = json['fileSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fileLoc'] = fileLoc;
    data['fileName'] = fileName;
    data['fileSize'] = fileSize;
    return data;
  }
}
