// To parse this JSON data, do
//
//     final infoCharacterModel = infoCharacterModelFromJson(jsonString);

import 'dart:convert';

InfoCharacterModel infoCharacterModelFromJson(String str) =>
    InfoCharacterModel.fromJson(json.decode(str));

String infoCharacterModelToJson(InfoCharacterModel data) =>
    json.encode(data.toJson());

class InfoCharacterModel {
  final List<Datum>? data;

  InfoCharacterModel({
    this.data,
  });

  factory InfoCharacterModel.fromJson(Map<String, dynamic> json) =>
      InfoCharacterModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final Character? character;
  final Role? role;
  final int? favorites;
  final List<VoiceActor>? voiceActors;

  Datum({
    this.character,
    this.role,
    this.favorites,
    this.voiceActors,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        character: json["character"] == null
            ? null
            : Character.fromJson(json["character"]),
        role: roleValues.map[json["role"]]!,
        favorites: json["favorites"],
        voiceActors: json["voice_actors"] == null
            ? []
            : List<VoiceActor>.from(
                json["voice_actors"]!.map((x) => VoiceActor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "character": character?.toJson(),
        "role": roleValues.reverse[role],
        "favorites": favorites,
        "voice_actors": voiceActors == null
            ? []
            : List<dynamic>.from(voiceActors!.map((x) => x.toJson())),
      };
}

class Character {
  final int? malId;
  final String? url;
  final CharacterImages? images;
  final String? name;

  Character({
    this.malId,
    this.url,
    this.images,
    this.name,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        malId: json["mal_id"],
        url: json["url"],
        images: json["images"] == null
            ? null
            : CharacterImages.fromJson(json["images"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": images?.toJson(),
        "name": name,
      };
}

class CharacterImages {
  final Jpg? jpg;
  final Webp? webp;

  CharacterImages({
    this.jpg,
    this.webp,
  });

  factory CharacterImages.fromJson(Map<String, dynamic> json) =>
      CharacterImages(
        jpg: json["jpg"] == null ? null : Jpg.fromJson(json["jpg"]),
        webp: json["webp"] == null ? null : Webp.fromJson(json["webp"]),
      );

  Map<String, dynamic> toJson() => {
        "jpg": jpg?.toJson(),
        "webp": webp?.toJson(),
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

class Webp {
  final String? imageUrl;
  final String? smallImageUrl;

  Webp({
    this.imageUrl,
    this.smallImageUrl,
  });

  factory Webp.fromJson(Map<String, dynamic> json) => Webp(
        imageUrl: json["image_url"],
        smallImageUrl: json["small_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "small_image_url": smallImageUrl,
      };
}

enum Role { MAIN, SUPPORTING }

final roleValues =
    EnumValues({"Main": Role.MAIN, "Supporting": Role.SUPPORTING});

class VoiceActor {
  final Person? person;
  final Language? language;

  VoiceActor({
    this.person,
    this.language,
  });

  factory VoiceActor.fromJson(Map<String, dynamic> json) => VoiceActor(
        person: json["person"] == null ? null : Person.fromJson(json["person"]),
        language: languageValues.map[json["language"]],
      );

  Map<String, dynamic> toJson() => {
        "person": person?.toJson(),
        "language": languageValues.reverse[language],
      };
}

enum Language {
  ENGLISH,
  FRENCH,
  GERMAN,
  ITALIAN,
  JAPANESE,
  PORTUGUESE_BR,
  SPANISH
}

final languageValues = EnumValues({
  "English": Language.ENGLISH,
  "French": Language.FRENCH,
  "German": Language.GERMAN,
  "Italian": Language.ITALIAN,
  "Japanese": Language.JAPANESE,
  "Portuguese (BR)": Language.PORTUGUESE_BR,
  "Spanish": Language.SPANISH
});

class Person {
  final int? malId;
  final String? url;
  final PersonImages? images;
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
        images: json["images"] == null
            ? null
            : PersonImages.fromJson(json["images"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": images?.toJson(),
        "name": name,
      };
}

class PersonImages {
  final Jpg? jpg;

  PersonImages({
    this.jpg,
  });

  factory PersonImages.fromJson(Map<String, dynamic> json) => PersonImages(
        jpg: json["jpg"] == null ? null : Jpg.fromJson(json["jpg"]),
      );

  Map<String, dynamic> toJson() => {
        "jpg": jpg?.toJson(),
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
