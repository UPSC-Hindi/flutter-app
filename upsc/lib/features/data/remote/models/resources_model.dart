
class ResourcesModel {
  ResourcesModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  final bool status;
  final List<ResourcesDataModel> data;
  final String msg;

  factory ResourcesModel.fromJson(Map<String, dynamic> json) => ResourcesModel(
    status: json["status"],
    data: List<ResourcesDataModel>.from(json["data"].map((x) => ResourcesDataModel.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class ResourcesDataModel {
  ResourcesDataModel({
    required this.id,
    required this.user,
    required this.category,
    required this.subject,
    required this.title,
    required this.fileUrl,
    required this.language,
    required this.createdAt,
    required this.resourceType,
    required this.v,
  });

  final String id;
  final String user;
  final Category category;
  final String subject;
  final String title;
  final String fileUrl;
  final String language;
  final String createdAt;
  final String resourceType;
  final int v;

  factory ResourcesDataModel.fromJson(Map<String, dynamic> json) => ResourcesDataModel(
    id: json["_id"],
    user: json["user"],
    category: Category.fromJson(json["category"]),
    subject: json["subject"],
    title: json["title"],
    fileUrl: json["file_url"],
    language: json["language"],
    createdAt: json["Created_At"],
    resourceType: json["resource_type"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "category": category.toJson(),
    "subject": subject,
    "title": title,
    "file_url": fileUrl,
    "language": language,
    "Created_At": createdAt,
    "resource_type": resourceType,
    "__v": v,
  };
}

class Category {
  Category({
    required this.id,
    required this.title,
    required this.isActive,
    required this.createdAt,
    required this.type,
    required this.user,
    required this.v,
  });

  final String id;
  final String title;
  final bool isActive;
  final String createdAt;
  final String type;
  final String user;
  final int v;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    title: json["title"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    type: json["type"],
    user: json["user"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "is_active": isActive,
    "created_at": createdAt,
    "type": type,
    "user": user,
    "__v": v,
  };
}
