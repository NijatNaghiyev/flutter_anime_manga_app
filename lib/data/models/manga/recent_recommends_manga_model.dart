// To parse this JSON data, do
//
//     final recentRecommendsMangaModel = recentRecommendsMangaModelFromJson(jsonString);

import 'dart:convert';

List<RecentRecommendsMangaModel> recentRecommendsMangaModelFromJson(
        String str) =>
    List<RecentRecommendsMangaModel>.from(
        json.decode(str).map((x) => RecentRecommendsMangaModel.fromJson(x)));

String recentRecommendsMangaModelToJson(
        List<RecentRecommendsMangaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecentRecommendsMangaModel {
  final String? malId;
  final List<Entry>? entry;
  final String? content;
  final DateTime? date;
  final User? user;

  RecentRecommendsMangaModel({
    this.malId,
    this.entry,
    this.content,
    this.date,
    this.user,
  });

  factory RecentRecommendsMangaModel.fromJson(Map<String, dynamic> json) =>
      RecentRecommendsMangaModel(
        malId: json["mal_id"],
        entry: json["entry"] == null
            ? []
            : List<Entry>.from(json["entry"]!.map((x) => Entry.fromJson(x))),
        content: json["content"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "entry": entry == null
            ? []
            : List<dynamic>.from(entry!.map((x) => x.toJson())),
        "content": content,
        "date": date?.toIso8601String(),
        "user": user?.toJson(),
      };
}

class Entry {
  final int? malId;
  final String? url;
  final Map<String, ImageR>? images;
  final String? title;

  Entry({
    this.malId,
    this.url,
    this.images,
    this.title,
  });

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        malId: json["mal_id"],
        url: json["url"],
        images: Map.from(json["images"]!)
            .map((k, v) => MapEntry<String, ImageR>(k, ImageR.fromJson(v))),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": Map.from(images!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "title": title,
      };
}

class ImageR {
  final String? imageUrl;
  final String? smallImageUrl;
  final String? largeImageUrl;

  ImageR({
    this.imageUrl,
    this.smallImageUrl,
    this.largeImageUrl,
  });

  factory ImageR.fromJson(Map<String, dynamic> json) => ImageR(
        imageUrl: json["image_url"],
        smallImageUrl: json["small_image_url"],
        largeImageUrl: json["large_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "small_image_url": smallImageUrl,
        "large_image_url": largeImageUrl,
      };
}

class User {
  final String? url;
  final String? username;

  User({
    this.url,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        url: json["url"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "username": username,
      };
}
