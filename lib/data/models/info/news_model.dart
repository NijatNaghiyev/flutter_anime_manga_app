// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  final int? malId;
  final String? url;
  final String? title;
  final DateTime? date;
  final String? authorUsername;
  final String? authorUrl;
  final String? forumUrl;
  final Images? images;
  final int? comments;
  final String? excerpt;

  NewsModel({
    this.malId,
    this.url,
    this.title,
    this.date,
    this.authorUsername,
    this.authorUrl,
    this.forumUrl,
    this.images,
    this.comments,
    this.excerpt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        malId: json["mal_id"],
        url: json["url"],
        title: json["title"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        authorUsername: json["author_username"],
        authorUrl: json["author_url"],
        forumUrl: json["forum_url"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        comments: json["comments"],
        excerpt: json["excerpt"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "title": title,
        "date": date?.toIso8601String(),
        "author_username": authorUsername,
        "author_url": authorUrl,
        "forum_url": forumUrl,
        "images": images?.toJson(),
        "comments": comments,
        "excerpt": excerpt,
      };
}

class Images {
  final Jpg? jpg;

  Images({
    this.jpg,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        jpg: json["jpg"] == null ? null : Jpg.fromJson(json["jpg"]),
      );

  Map<String, dynamic> toJson() => {
        "jpg": jpg?.toJson(),
      };
}

class Jpg {
  final String? imageUrl;

  Jpg({
    this.imageUrl,
  });

  factory Jpg.fromJson(Map<String, dynamic> json) => Jpg(
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
      };
}
