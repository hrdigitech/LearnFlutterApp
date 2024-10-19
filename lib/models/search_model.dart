

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  int code;
  int status;
  String message;
  List<Datum> data;

  SearchModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String thumbnail;
  int? playlistId;
  String title;
  int view;
  int like;
  int comment;
  int followers;
  String description;
  String previewImg;
  String githubLink;
  String youtubeLink;
  String? linkdinLink;
  dynamic features;
  DateTime createdAt;
  DateTime updatedAt;
  bool islike;

  Datum({
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
    required this.islike,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    islike: json["islike"],
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
    "islike": islike,
  };
}
