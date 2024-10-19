

import 'dart:convert';

VideoDetailsModel videoDetailsModelFromJson(String str) => VideoDetailsModel.fromJson(json.decode(str));

String videoDetailsModelToJson(VideoDetailsModel data) => json.encode(data.toJson());

class VideoDetailsModel {
  int code;
  int status;
  String message;
  bool islike;
  Data data;

  VideoDetailsModel({
    required this.code,
    required this.status,
    required this.message,
    required this.islike,
    required this.data,
  });

  factory VideoDetailsModel.fromJson(Map<String, dynamic> json) => VideoDetailsModel(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    islike: json["islike"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "islike": islike,
    "data": data.toJson(),
  };
}

class Data {
  int id;
  String thumbnail;
  int playlistId;
  String title;
  int view;
  int like;
  int comment;
  int followers;
  String description;
  String previewImg;
  String githubLink;
  String youtubeLink;
  dynamic linkdinLink;
  dynamic features;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.thumbnail,
    required this.playlistId,
    required this.title,
    required this.view,
    required this.like,
    required this.comment,
    required this.followers,
    required this.description,
    required this.previewImg,
    required this.githubLink,
    required this.youtubeLink,
    required this.linkdinLink,
    required this.features,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    thumbnail: json["thumbnail"],
    playlistId: json["playlist_id"],
    title: json["title"],
    view: json["view"],
    like: json["like"],
    comment: json["comment"],
    followers: json["followers"],
    description: json["description"],
    previewImg: json["preview_img"],
    githubLink: json["github_link"],
    youtubeLink: json["youtube_link"],
    linkdinLink: json["linkdin_link"],
    features: json["features"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "thumbnail": thumbnail,
    "playlist_id": playlistId,
    "title": title,
    "view": view,
    "like": like,
    "comment": comment,
    "followers": followers,
    "description": description,
    "preview_img": previewImg,
    "github_link": githubLink,
    "youtube_link": youtubeLink,
    "linkdin_link": linkdinLink,
    "features": features,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
