// To parse this JSON data, do
//
//     final animeStaffModel = animeStaffModelFromJson(jsonString);

import 'dart:convert';

AnimeStaffModel animeStaffModelFromJson(String str) =>
    AnimeStaffModel.fromJson(json.decode(str));

String animeStaffModelToJson(AnimeStaffModel data) =>
    json.encode(data.toJson());

class AnimeStaffModel {
  final Person? person;
  final List<String>? positions;

  AnimeStaffModel({
    this.person,
    this.positions,
  });

  factory AnimeStaffModel.fromJson(Map<String, dynamic> json) =>
      AnimeStaffModel(
        person: json["person"] == null ? null : Person.fromJson(json["person"]),
        positions: json["positions"] == null
            ? []
            : List<String>.from(json["positions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "person": person?.toJson(),
        "positions": positions == null
            ? []
            : List<dynamic>.from(positions!.map((x) => x)),
      };
}

class Person {
  final int? malId;
  final String? url;
  final Images? images;
  final String? name;

  Person({
    this.malId,
    this.url,
    this.images,
    this.name,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        malId: json["mal_id"],
        url: json["url"],
        images: json["images"] == null ? null : Images.fromJson(json["images"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": images?.toJson(),
        "name": name,
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
