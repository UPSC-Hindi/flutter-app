class TestSeriesDetails {
  bool? status;
  List<TestSeriesDetailsData>? data;
  String? msg;

  TestSeriesDetails({this.status, this.data, this.msg});

  TestSeriesDetails.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['data'] != null) {
      data = <TestSeriesDetailsData>[];
      json['data'].forEach((v) {
        data!.add(TestSeriesDetailsData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class TestSeriesDetailsData {
  String? sId;
  String? userAdmin;
  String? testSeries;
  String? testTitle;
  String? testCode;
  String? instructions;
  String? startingDate;
  String? createdAt;
  int? noOfQuestions;
  QuestionPaper? questionPaper;
  QuestionPaper? answerTemplate;
  String? questionPaperType;
  String? updatedAt;
  bool? negativemarking;
  String? duration;
  int? iV;

  TestSeriesDetailsData(
      {this.sId,
      this.userAdmin,
      this.testSeries,
      this.testTitle,
      this.testCode,
      this.instructions,
      this.startingDate,
      this.createdAt,
      this.noOfQuestions,
      this.questionPaper,
      this.answerTemplate,
      this.questionPaperType,
      this.updatedAt,
      this.negativemarking,
      this.duration,
      this.iV});

  TestSeriesDetailsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userAdmin = json['user_admin'];
    testSeries = json['TestSeries'];
    testTitle = json['Test_title'];
    testCode = json['Test_code'];
    instructions = json['instructions'];
    startingDate = json['starting_date'];
    createdAt = json['created_at'];
    noOfQuestions = json['No_of_questions'];
    questionPaper = json['question_paper'] != null
        ? QuestionPaper.fromJson(json['question_paper'])
        : null;
    answerTemplate = json['answer_template'] != null
        ? QuestionPaper.fromJson(json['answer_template'])
        : null;
    questionPaperType = json['question_paper_type'];
    updatedAt = json['updated_at'];
    negativemarking = json['negativemarking'];
    duration = json['duration'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['user_admin'] = userAdmin;
    data['TestSeries'] = testSeries;
    data['Test_title'] = testTitle;
    data['Test_code'] = testCode;
    data['instructions'] = instructions;
    data['starting_date'] = startingDate;
    data['created_at'] = createdAt;
    data['No_of_questions'] = noOfQuestions;
    if (questionPaper != null) {
      data['question_paper'] = questionPaper!.toJson();
    }
    if (answerTemplate != null) {
      data['answer_template'] = answerTemplate!.toJson();
    }
    data['question_paper_type'] = questionPaperType;
    data['updated_at'] = updatedAt;
    data['negativemarking'] = negativemarking;
    data['duration'] = duration;
    data['__v'] = iV;
    return data;
  }
}

class QuestionPaper {
  String? fileLoc;
  String? fileName;
  String? fileSize;

  QuestionPaper({this.fileLoc, this.fileName, this.fileSize});

  QuestionPaper.fromJson(Map<String, dynamic> json) {
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
