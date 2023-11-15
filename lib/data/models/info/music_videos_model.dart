// To parse this JSON data, do
//
//     final musicVideosModel = musicVideosModelFromJson(jsonString);

import 'dart:convert';

List<MusicVideosModel> musicVideosModelFromJson(String str) =>
    List<MusicVideosModel>.from(
        json.decode(str).map((x) => MusicVideosModel.fromJson(x)));

String musicVideosModelToJson(List<MusicVideosModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MusicVideosModel {
  final String? title;
  final Video? video;
  final Meta? meta;

  MusicVideosModel({
    this.title,
    this.video,
    this.meta,
  });

  factory MusicVideosModel.fromJson(Map<String, dynamic> json) =>
      MusicVideosModel(
        title: json["title"],
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "video": video?.toJson(),
        "meta": meta?.toJson(),
      };
}

class Meta {
  final String? title;
  final String? author;

  Meta({
    this.title,
    this.author,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        title: json["title"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
      };
}

class Video {
  final String? youtubeId;
  final String? url;
  final String? embedUrl;
  final Images? images;

  Video({
    this.youtubeId,
    this.url,
    this.embedUrl,
    this.images,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        youtubeId: json["youtube_id"],
        url: json["url"],
        embedUrl: json["embed_url"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "youtube_id": youtubeId,
        "url": url,
        "embed_url": embedUrl,
        "images": images?.toJson(),
      };
}

class Images {
  final String? imageUrl;
  final String? smallImageUrl;
  final String? mediumImageUrl;
  final String? largeImageUrl;
  final String? maximumImageUrl;

  Images({
    this.imageUrl,
    this.smallImageUrl,
    this.mediumImageUrl,
    this.largeImageUrl,
    this.maximumImageUrl,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        imageUrl: json["image_url"],
        smallImageUrl: json["small_image_url"],
        mediumImageUrl: json["medium_image_url"],
        largeImageUrl: json["large_image_url"],
        maximumImageUrl: json["maximum_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "small_image_url": smallImageUrl,
        "medium_image_url": mediumImageUrl,
        "large_image_url": largeImageUrl,
        "maximum_image_url": maximumImageUrl,
      };
}
