// To parse this JSON data, do
//
//     final reviewsAnimeModel = reviewsAnimeModelFromJson(jsonString);

import 'dart:convert';

List<RecentReviewsAnimeModel> reviewsAnimeModelFromJson(String str) =>
    List<RecentReviewsAnimeModel>.from(
        json.decode(str).map((x) => RecentReviewsAnimeModel.fromJson(x)));

String reviewsAnimeModelToJson(List<RecentReviewsAnimeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecentReviewsAnimeModel {
  final int malId;
  final String url;
  final Type type;
  final Reactions reactions;
  final DateTime date;
  final String review;
  final int score;
  final List<Tag> tags;
  final bool isSpoiler;
  final bool isPreliminary;
  final dynamic episodesWatched;
  final Entry entry;
  final User user;

  RecentReviewsAnimeModel({
    required this.malId,
    required this.url,
    required this.type,
    required this.reactions,
    required this.date,
    required this.review,
    required this.score,
    required this.tags,
    required this.isSpoiler,
    required this.isPreliminary,
    required this.episodesWatched,
    required this.entry,
    required this.user,
  });

  factory RecentReviewsAnimeModel.fromJson(Map<String, dynamic> json) =>
      RecentReviewsAnimeModel(
        malId: json["mal_id"],
        url: json["url"],
        type: typeValues.map[json["type"]]!,
        reactions: Reactions.fromJson(json["reactions"]),
        date: DateTime.parse(json["date"]),
        review: json["review"],
        score: json["score"],
        tags: List<Tag>.from(json["tags"].map((x) => tagValues.map[x]!)),
        isSpoiler: json["is_spoiler"],
        isPreliminary: json["is_preliminary"],
        episodesWatched: json["episodes_watched"],
        entry: Entry.fromJson(json["entry"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "type": typeValues.reverse[type],
        "reactions": reactions.toJson(),
        "date": date.toIso8601String(),
        "review": review,
        "score": score,
        "tags": List<dynamic>.from(tags.map((x) => tagValues.reverse[x])),
        "is_spoiler": isSpoiler,
        "is_preliminary": isPreliminary,
        "episodes_watched": episodesWatched,
        "entry": entry.toJson(),
        "user": user.toJson(),
      };
}

class Entry {
  final int malId;
  final String url;
  final Map<String, EntryImage> images;
  final String title;

  Entry({
    required this.malId,
    required this.url,
    required this.images,
    required this.title,
  });

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        malId: json["mal_id"],
        url: json["url"],
        images: Map.from(json["images"]).map(
            (k, v) => MapEntry<String, EntryImage>(k, EntryImage.fromJson(v))),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": Map.from(images)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "title": title,
      };
}

class EntryImage {
  final String imageUrl;
  final String smallImageUrl;
  final String largeImageUrl;

  EntryImage({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });

  factory EntryImage.fromJson(Map<String, dynamic> json) => EntryImage(
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

class Reactions {
  final int overall;
  final int nice;
  final int loveIt;
  final int funny;
  final int confusing;
  final int informative;
  final int wellWritten;
  final int creative;

  Reactions({
    required this.overall,
    required this.nice,
    required this.loveIt,
    required this.funny,
    required this.confusing,
    required this.informative,
    required this.wellWritten,
    required this.creative,
  });

  factory Reactions.fromJson(Map<String, dynamic> json) => Reactions(
        overall: json["overall"],
        nice: json["nice"],
        loveIt: json["love_it"],
        funny: json["funny"],
        confusing: json["confusing"],
        informative: json["informative"],
        wellWritten: json["well_written"],
        creative: json["creative"],
      );

  Map<String, dynamic> toJson() => {
        "overall": overall,
        "nice": nice,
        "love_it": loveIt,
        "funny": funny,
        "confusing": confusing,
        "informative": informative,
        "well_written": wellWritten,
        "creative": creative,
      };
}

enum Tag { MIXED_FEELINGS, NOT_RECOMMENDED, RECOMMENDED }

final tagValues = EnumValues({
  "Mixed Feelings": Tag.MIXED_FEELINGS,
  "Not Recommended": Tag.NOT_RECOMMENDED,
  "Recommended": Tag.RECOMMENDED
});

enum Type { ANIME }

final typeValues = EnumValues({"anime": Type.ANIME});

class User {
  final String url;
  final String username;
  final Map<String, UserImage> images;

  User({
    required this.url,
    required this.username,
    required this.images,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        url: json["url"],
        username: json["username"],
        images: Map.from(json["images"]).map(
            (k, v) => MapEntry<String, UserImage>(k, UserImage.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "username": username,
        "images": Map.from(images)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class UserImage {
  final String imageUrl;

  UserImage({
    required this.imageUrl,
  });

  factory UserImage.fromJson(Map<String, dynamic> json) => UserImage(
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
