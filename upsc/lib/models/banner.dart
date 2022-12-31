class getbannerdetails {
  bool? status;
  List<Data>? data;
  String? msg;

  getbannerdetails({this.status, this.data, this.msg});

  getbannerdetails.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  List<String>? bannerUrl;
  String? title;
  String? language;
  bool? isActive;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
      this.user,
      this.bannerUrl,
      this.title,
      this.language,
      this.isActive,
      this.createdAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    bannerUrl = json['banner_url'].cast<String>();
    title = json['title'];
    language = json['language'];
   
    isActive = json['is_active'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['user'] = user;
    data['banner_url'] = bannerUrl;
    data['title'] = title;
    data['language'] = language;

    data['is_active'] = isActive;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
