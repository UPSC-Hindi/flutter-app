class ResourcesModel {
  bool? status;
  List<ResourcesDataModel>? data;
  String? msg;

  ResourcesModel({this.status, this.data, this.msg});

  ResourcesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ResourcesDataModel>[];
      json['data'].forEach((v) {
        data!.add(ResourcesDataModel.fromJson(v));
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

class ResourcesDataModel {
  String? sId;
  String? user;
  Category? category;
  String? subject;
  String? title;
  String? fileUrl;
  String? language;
  int? iV;
  bool? isActive;

  ResourcesDataModel(
      {this.sId,
      this.user,
      this.category,
      this.subject,
      this.title,
      this.fileUrl,
      this.language,
      this.iV,
      this.isActive});

  ResourcesDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    subject = json['subject'];
    title = json['title'];
    fileUrl = json['file_url'];
    language = json['language'];
    iV = json['__v'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['user'] = user;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['subject'] = subject;
    data['title'] = title;
    data['file_url'] = fileUrl;
    data['language'] = language;
    data['__v'] = iV;
    data['is_active'] = isActive;
    return data;
  }
}

class Category {
  String? sId;
  String? title;
  bool? isActive;
  String? createdAt;
  String? user;
  int? iV;

  Category(
      {this.sId,
      this.title,
      this.isActive,
      this.createdAt,
      this.user,
      this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    user = json['user'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['title'] = title;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['user'] = user;
    data['__v'] = iV;
    return data;
  }
}
