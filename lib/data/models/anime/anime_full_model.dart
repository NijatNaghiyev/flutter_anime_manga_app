// To parse this JSON data, do
//
//     final animeFullModel = animeFullModelFromJson(jsonString);

import 'dart:convert';

AnimeFullModel animeFullModelFromJson(String str) =>
    AnimeFullModel.fromJson(json.decode(str));

String animeFullModelToJson(AnimeFullModel data) => json.encode(data.toJson());

class AnimeFullModel {
  final Data? data;

  AnimeFullModel({
    this.data,
  });

  factory AnimeFullModel.fromJson(Map<String, dynamic> json) => AnimeFullModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? malId;
  final String? url;
  final Map<String, ImageA>? images;
  final Trailer? trailer;
  final bool? approved;
  final List<Title>? titles;
  final String? title;
  final String? titleEnglish;
  final String? titleJapanese;
  final List<String>? titleSynonyms;
  final String? type;
  final String? source;
  final int? episodes;
  final String? status;
  final bool? airing;
  final Aired? aired;
  final String? duration;
  final String? rating;
  final double? score;
  final int? scoredBy;
  final int? rank;
  final int? popularity;
  final int? members;
  final int? favorites;
  final String? synopsis;
  final dynamic background;
  final String? season;
  final int? year;
  final Broadcast? broadcast;
  final List<Genre>? producers;
  final List<dynamic>? licensors;
  final List<Genre>? studios;
  final List<Genre>? genres;
  final List<dynamic>? explicitGenres;
  final List<Genre>? themes;
  final List<dynamic>? demographics;
  final List<Relation>? relations;
  final ThemeA? themeA;
  final List<External>? dataExternal;
  final List<External>? streaming;

  Data({
    this.malId,
    this.url,
    this.images,
    this.trailer,
    this.approved,
    this.titles,
    this.title,
    this.titleEnglish,
    this.titleJapanese,
    this.titleSynonyms,
    this.type,
    this.source,
    this.episodes,
    this.status,
    this.airing,
    this.aired,
    this.duration,
    this.rating,
    this.score,
    this.scoredBy,
    this.rank,
    this.popularity,
    this.members,
    this.favorites,
    this.synopsis,
    this.background,
    this.season,
    this.year,
    this.broadcast,
    this.producers,
    this.licensors,
    this.studios,
    this.genres,
    this.explicitGenres,
    this.themes,
    this.demographics,
    this.relations,
    this.themeA,
    this.dataExternal,
    this.streaming,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        malId: json["mal_id"],
        url: json["url"],
        images: Map.from(json["images"]!)
            .map((k, v) => MapEntry<String, ImageA>(k, ImageA.fromJson(v))),
        trailer:
            json["trailer"] == null ? null : Trailer.fromJson(json["trailer"]),
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
        source: json["source"],
        episodes: json["episodes"],
        status: json["status"],
        airing: json["airing"],
        aired: json["aired"] == null ? null : Aired.fromJson(json["aired"]),
        duration: json["duration"],
        rating: json["rating"],
        score: json["score"]?.toDouble(),
        scoredBy: json["scored_by"],
        rank: json["rank"],
        popularity: json["popularity"],
        members: json["members"],
        favorites: json["favorites"],
        synopsis: json["synopsis"],
        background: json["background"],
        season: json["season"],
        year: json["year"],
        broadcast: json["broadcast"] == null
            ? null
            : Broadcast.fromJson(json["broadcast"]),
        producers: json["producers"] == null
            ? []
            : List<Genre>.from(
                json["producers"]!.map((x) => Genre.fromJson(x))),
        licensors: json["licensors"] == null
            ? []
            : List<dynamic>.from(json["licensors"]!.map((x) => x)),
        studios: json["studios"] == null
            ? []
            : List<Genre>.from(json["studios"]!.map((x) => Genre.fromJson(x))),
        genres: json["genres"] == null
            ? []
            : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
        explicitGenres: json["explicit_genres"] == null
            ? []
            : List<dynamic>.from(json["explicit_genres"]!.map((x) => x)),
        themes: json["themes"] == null
            ? []
            : List<Genre>.from(json["themes"]!.map((x) => Genre.fromJson(x))),
        demographics: json["demographics"] == null
            ? []
            : List<dynamic>.from(json["demographics"]!.map((x) => x)),
        relations: json["relations"] == null
            ? []
            : List<Relation>.from(
                json["relations"]!.map((x) => Relation.fromJson(x))),
        themeA: json["theme"] == null ? null : ThemeA.fromJson(json["theme"]),
        dataExternal: json["external"] == null
            ? []
            : List<External>.from(
                json["external"]!.map((x) => External.fromJson(x))),
        streaming: json["streaming"] == null
            ? []
            : List<External>.from(
                json["streaming"]!.map((x) => External.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": Map.from(images!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "trailer": trailer?.toJson(),
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
        "source": source,
        "episodes": episodes,
        "status": status,
        "airing": airing,
        "aired": aired?.toJson(),
        "duration": duration,
        "rating": rating,
        "score": score,
        "scored_by": scoredBy,
        "rank": rank,
        "popularity": popularity,
        "members": members,
        "favorites": favorites,
        "synopsis": synopsis,
        "background": background,
        "season": season,
        "year": year,
        "broadcast": broadcast?.toJson(),
        "producers": producers == null
            ? []
            : List<dynamic>.from(producers!.map((x) => x.toJson())),
        "licensors": licensors == null
            ? []
            : List<dynamic>.from(licensors!.map((x) => x)),
        "studios": studios == null
            ? []
            : List<dynamic>.from(studios!.map((x) => x.toJson())),
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
            : List<dynamic>.from(demographics!.map((x) => x)),
        "relations": relations == null
            ? []
            : List<dynamic>.from(relations!.map((x) => x.toJson())),
        "theme": themeA?.toJson(),
        "external": dataExternal == null
            ? []
            : List<dynamic>.from(dataExternal!.map((x) => x.toJson())),
        "streaming": streaming == null
            ? []
            : List<dynamic>.from(streaming!.map((x) => x.toJson())),
      };
}

class Aired {
  final DateTime? from;
  final dynamic to;
  final Prop? prop;
  final String? string;

  Aired({
    this.from,
    this.to,
    this.prop,
    this.string,
  });

  factory Aired.fromJson(Map<String, dynamic> json) => Aired(
        from: json["from"] == null ? null : DateTime.parse(json["from"]),
        to: json["to"],
        prop: json["prop"] == null ? null : Prop.fromJson(json["prop"]),
        string: json["string"],
      );

  Map<String, dynamic> toJson() => {
        "from": from?.toIso8601String(),
        "to": to,
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

class Broadcast {
  final String? day;
  final String? time;
  final String? timezone;
  final String? string;

  Broadcast({
    this.day,
    this.time,
    this.timezone,
    this.string,
  });

  factory Broadcast.fromJson(Map<String, dynamic> json) => Broadcast(
        day: json["day"],
        time: json["time"],
        timezone: json["timezone"],
        string: json["string"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "time": time,
        "timezone": timezone,
        "string": string,
      };
}

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

class Genre {
  final int? malId;
  final Type? type;
  final String? name;
  final String? url;

  Genre({
    this.malId,
    this.type,
    this.name,
    this.url,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
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

enum Type { ANIME, MANGA }

final typeValues = EnumValues({"anime": Type.ANIME, "manga": Type.MANGA});

class ImageA {
  final String? imageUrl;
  final String? smallImageUrl;
  final String? largeImageUrl;

  ImageA({
    this.imageUrl,
    this.smallImageUrl,
    this.largeImageUrl,
  });

  factory ImageA.fromJson(Map<String, dynamic> json) => ImageA(
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

class Relation {
  final String? relation;
  final List<Genre>? entry;

  Relation({
    this.relation,
    this.entry,
  });

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
        relation: json["relation"],
        entry: json["entry"] == null
            ? []
            : List<Genre>.from(json["entry"]!.map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "relation": relation,
        "entry": entry == null
            ? []
            : List<dynamic>.from(entry!.map((x) => x.toJson())),
      };
}

class ThemeA {
  final List<String>? openings;
  final List<String>? endings;

  ThemeA({
    this.openings,
    this.endings,
  });

  factory ThemeA.fromJson(Map<String, dynamic> json) => ThemeA(
        openings: json["openings"] == null
            ? []
            : List<String>.from(json["openings"]!.map((x) => x)),
        endings: json["endings"] == null
            ? []
            : List<String>.from(json["endings"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "openings":
            openings == null ? [] : List<dynamic>.from(openings!.map((x) => x)),
        "endings":
            endings == null ? [] : List<dynamic>.from(endings!.map((x) => x)),
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

class Trailer {
  final String? youtubeId;
  final String? url;
  final String? embedUrl;
  final Images? images;

  Trailer({
    this.youtubeId,
    this.url,
    this.embedUrl,
    this.images,
  });

  factory Trailer.fromJson(Map<String, dynamic> json) => Trailer(
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
