
class VideoModel {
  VideoModel({
    required this.id,
    required this.user,
    required this.title,
    required this.videoUrl,
    required this.isActive,
    required this.createdAt,
  });

  final String id;
  final String user;
  final String title;
  final String videoUrl;
  final bool isActive;
  final DateTime createdAt;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    id: json["_id"],
    user: json["user"],
    title: json["title"],
    videoUrl: json["video_url"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "title": title,
    "video_url": videoUrl,
    "is_active": isActive,
    "created_at": createdAt.toIso8601String(),
  };
}
