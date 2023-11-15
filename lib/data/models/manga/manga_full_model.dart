// To parse this JSON data, do
//
//     final mangaFullModel = mangaFullModelFromJson(jsonString);

import 'dart:convert';

MangaFullModel mangaFullModelFromJson(String str) =>
    MangaFullModel.fromJson(json.decode(str));

String mangaFullModelToJson(MangaFullModel data) => json.encode(data.toJson());

class MangaFullModel {
  final Data? data;

  MangaFullModel({
    this.data,
  });

  factory MangaFullModel.fromJson(Map<String, dynamic> json) => MangaFullModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? malId;
  final String? url;
  final Map<String, Image>? images;
  final bool? approved;
  final List<Title>? titles;
  final String? title;
  final String? titleEnglish;
  final String? titleJapanese;
  final List<String>? titleSynonyms;
  final String? type;
  final int? chapters;
  final int? volumes;
  final String? status;
  final bool? publishing;
  final Published? published;
  final double? score;
  final double? scored;
  final int? scoredBy;
  final int? rank;
  final int? popularity;
  final int? members;
  final int? favorites;
  final String? synopsis;
  final String? background;
  final List<Author>? authors;
  final List<Author>? serializations;
  final List<Author>? genres;
  final List<dynamic>? explicitGenres;
  final List<Author>? themes;
  final List<Author>? demographics;
  final List<Relation>? relations;
  final List<External>? dataExternal;

  Data({
    this.malId,
    this.url,
    this.images,
    this.approved,
    this.titles,
    this.title,
    this.titleEnglish,
    this.titleJapanese,
    this.titleSynonyms,
    this.type,
    this.chapters,
    this.volumes,
    this.status,
    this.publishing,
    this.published,
    this.score,
    this.scored,
    this.scoredBy,
    this.rank,
    this.popularity,
    this.members,
    this.favorites,
    this.synopsis,
    this.background,
    this.authors,
    this.serializations,
    this.genres,
    this.explicitGenres,
    this.themes,
    this.demographics,
    this.relations,
    this.dataExternal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        malId: json["mal_id"],
        url: json["url"],
        images: Map.from(json["images"]!)
            .map((k, v) => MapEntry<String, Image>(k, Image.fromJson(v))),
        approved: json["approved"],
        titles: json["titles"] == null
            ? []
            : List<Title>.from(json["titles"]!.map((x) => Title.fromJson(x))),
        title: json["title"],
        titleEnglish: json["title_english"],
        titleJapanese: json["title_japanese"],
        titleSynonyms: json["title_synonyms"] == null
            ? []
            : List<String>.from(json["title_synonyms"]!.map((x) => x)),
        type: json["type"],
        chapters: json["chapters"],
        volumes: json["volumes"],
        status: json["status"],
        publishing: json["publishing"],
        published: json["published"] == null
            ? null
            : Published.fromJson(json["published"]),
        score: json["score"]?.toDouble(),
        scored: json["scored"]?.toDouble(),
        scoredBy: json["scored_by"],
        rank: json["rank"],
        popularity: json["popularity"],
        members: json["members"],
        favorites: json["favorites"],
        synopsis: json["synopsis"],
        background: json["background"],
        authors: json["authors"] == null
            ? []
            : List<Author>.from(
                json["authors"]!.map((x) => Author.fromJson(x))),
        serializations: json["serializations"] == null
            ? []
            : List<Author>.from(
                json["serializations"]!.map((x) => Author.fromJson(x))),
        genres: json["genres"] == null
            ? []
            : List<Author>.from(json["genres"]!.map((x) => Author.fromJson(x))),
        explicitGenres: json["explicit_genres"] == null
            ? []
            : List<dynamic>.from(json["explicit_genres"]!.map((x) => x)),
        themes: json["themes"] == null
            ? []
            : List<Author>.from(json["themes"]!.map((x) => Author.fromJson(x))),
        demographics: json["demographics"] == null
            ? []
            : List<Author>.from(
                json["demographics"]!.map((x) => Author.fromJson(x))),
        relations: json["relations"] == null
            ? []
            : List<Relation>.from(
                json["relations"]!.map((x) => Relation.fromJson(x))),
        dataExternal: json["external"] == null
            ? []
            : List<External>.from(
                json["external"]!.map((x) => External.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": Map.from(images!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "approved": approved,
        "titles": titles == null
            ? []
            : List<dynamic>.from(titles!.map((x) => x.toJson())),
        "title": title,
        "title_english": titleEnglish,
        "title_japanese": titleJapanese,
        "title_synonyms": titleSynonyms == null
            ? []
            : List<dynamic>.from(titleSynonyms!.map((x) => x)),
        "type": type,
        "chapters": chapters,
        "volumes": volumes,
        "status": status,
        "publishing": publishing,
        "published": published?.toJson(),
        "score": score,
        "scored": scored,
        "scored_by": scoredBy,
        "rank": rank,
        "popularity": popularity,
        "members": members,
        "favorites": favorites,
        "synopsis": synopsis,
        "background": background,
        "authors": authors == null
            ? []
            : List<dynamic>.from(authors!.map((x) => x.toJson())),
        "serializations": serializations == null
            ? []
            : List<dynamic>.from(serializations!.map((x) => x.toJson())),
        "genres": genres == null
            ? []
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
        "explicit_genres": explicitGenres == null
            ? []
            : List<dynamic>.from(explicitGenres!.map((x) => x)),
        "themes": themes == null
            ? []
            : List<dynamic>.from(themes!.map((x) => x.toJson())),
        "demographics": demographics == null
            ? []
            : List<dynamic>.from(demographics!.map((x) => x.toJson())),
        "relations": relations == null
            ? []
            : List<dynamic>.from(relations!.map((x) => x.toJson())),
        "external": dataExternal == null
            ? []
            : List<dynamic>.from(dataExternal!.map((x) => x.toJson())),
      };
}

class Author {
  final int? malId;
  final Type? type;
  final String? name;
  final String? url;

  Author({
    this.malId,
    this.type,
    this.name,
    this.url,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        malId: json["mal_id"],
        type: typeValues.map[json["type"]]!,
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "type": typeValues.reverse[type],
        "name": name,
        "url": url,
      };
}

enum Type { ANIME, MANGA, PEOPLE }

final typeValues = EnumValues(
    {"anime": Type.ANIME, "manga": Type.MANGA, "people": Type.PEOPLE});

class External {
  final String? name;
  final String? url;

  External({
    this.name,
    this.url,
  });

  factory External.fromJson(Map<String, dynamic> json) => External(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Image {
  final String? imageUrl;
  final String? smallImageUrl;
  final String? largeImageUrl;

  Image({
    this.imageUrl,
    this.smallImageUrl,
    this.largeImageUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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

class Published {
  final DateTime? from;
  final DateTime? to;
  final Prop? prop;
  final String? string;

  Published({
    this.from,
    this.to,
    this.prop,
    this.string,
  });

  factory Published.fromJson(Map<String, dynamic> json) => Published(
        from: json["from"] == null ? null : DateTime.parse(json["from"]),
        to: json["to"] == null ? null : DateTime.parse(json["to"]),
        prop: json["prop"] == null ? null : Prop.fromJson(json["prop"]),
        string: json["string"],
      );

  Map<String, dynamic> toJson() => {
        "from": from?.toIso8601String(),
        "to": to?.toIso8601String(),
        "prop": prop?.toJson(),
        "string": string,
      };
}

class Prop {
  final From? from;
  final From? to;

  Prop({
    this.from,
    this.to,
  });

  factory Prop.fromJson(Map<String, dynamic> json) => Prop(
        from: json["from"] == null ? null : From.fromJson(json["from"]),
        to: json["to"] == null ? null : From.fromJson(json["to"]),
      );

  Map<String, dynamic> toJson() => {
        "from": from?.toJson(),
        "to": to?.toJson(),
      };
}

class From {
  final int? day;
  final int? month;
  final int? year;

  From({
    this.day,
    this.month,
    this.year,
  });

  factory From.fromJson(Map<String, dynamic> json) => From(
        day: json["day"],
        month: json["month"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "month": month,
        "year": year,
      };
}

class Relation {
  final String? relation;
  final List<Author>? entry;

  Relation({
    this.relation,
    this.entry,
  });

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
        relation: json["relation"],
        entry: json["entry"] == null
            ? []
            : List<Author>.from(json["entry"]!.map((x) => Author.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "relation": relation,
        "entry": entry == null
            ? []
            : List<dynamic>.from(entry!.map((x) => x.toJson())),
      };
}

class Title {
  final String? type;
  final String? title;

  Title({
    this.type,
    this.title,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        type: json["type"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
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
