
class BannerModel {
  BannerModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  final bool status;
  final List<BannerDataModel> data;
  final String msg;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    status: json["status"],
    data: List<BannerDataModel>.from(json["data"].map((x) => BannerDataModel.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class BannerDataModel {
  BannerDataModel({
    required this.id,
    required this.bannerUrl,
    required this.title,
    required this.isActive,
    required this.createdAt,
  });

  final String id;
  final List<String> bannerUrl;
  final String title;
  final bool isActive;
  final String createdAt;

  factory BannerDataModel.fromJson(Map<String, dynamic> json) => BannerDataModel(
    id: json["_id"],
    bannerUrl: List<String>.from(json["banner_url"].map((x) => x)),
    title: json["title"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "banner_url": List<dynamic>.from(bannerUrl.map((x) => x)),
    "title": title,
    "is_active": isActive,
    "created_at": createdAt,
  };
}
