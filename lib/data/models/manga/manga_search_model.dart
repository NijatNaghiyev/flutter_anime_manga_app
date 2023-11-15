// To parse this JSON data, do
//
//     final mangaSearchModel = mangaSearchModelFromJson(jsonString);

import 'dart:convert';

MangaSearchModel mangaSearchModelFromJson(String str) =>
    MangaSearchModel.fromJson(json.decode(str));

String mangaSearchModelToJson(MangaSearchModel data) =>
    json.encode(data.toJson());

class MangaSearchModel {
  final Pagination? pagination;
  final List<MangaDatum>? data;

  MangaSearchModel({
    this.pagination,
    this.data,
  });

  factory MangaSearchModel.fromJson(Map<String, dynamic> json) =>
      MangaSearchModel(
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null
            ? []
            : List<MangaDatum>.from(
                json["data"]!.map((x) => MangaDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MangaDatum {
  final int? malId;
  final String? url;
  final Map<String, ImageUrl>? images;
  final bool? approved;
  final List<Title>? titles;
  final String? title;
  final String? titleEnglish;
  final String? titleJapanese;
  final List<String>? titleSynonyms;
  final String? type;
  final int? chapters;
  final int? volumes;
  final Status? status;
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

  MangaDatum({
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
  });

  factory MangaDatum.fromJson(Map<String, dynamic> json) => MangaDatum(
        malId: json["mal_id"],
        url: json["url"],
        images: Map.from(json["images"]!)
            .map((k, v) => MapEntry<String, ImageUrl>(k, ImageUrl.fromJson(v))),
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
        status: statusValues.map[json["status"]],
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
        "status": statusValues.reverse[status],
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
      };
}

class Author {
  final int? malId;
  final AuthorType? type;
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
        type: authorTypeValues.map[json["type"]]!,
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "type": authorTypeValues.reverse[type],
        "name": name,
        "url": url,
      };
}

enum AuthorType { MANGA, PEOPLE }

final authorTypeValues =
    EnumValues({"manga": AuthorType.MANGA, "people": AuthorType.PEOPLE});

class ImageUrl {
  final String? imageUrl;
  final String? smallImageUrl;
  final String? largeImageUrl;

  ImageUrl({
    this.imageUrl,
    this.smallImageUrl,
    this.largeImageUrl,
  });

  factory ImageUrl.fromJson(Map<String, dynamic> json) => ImageUrl(
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

enum Status { FINISHED, ON_HIATUS, PUBLISHING }

final statusValues = EnumValues({
  "Finished": Status.FINISHED,
  "On Hiatus": Status.ON_HIATUS,
  "Publishing": Status.PUBLISHING
});

class Title {
  final TitleType? type;
  final String? title;

  Title({
    this.type,
    this.title,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        type: titleTypeValues.map[json["type"]]!,
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "type": titleTypeValues.reverse[type],
        "title": title,
      };
}

enum TitleType { DEFAULT, ENGLISH, FRENCH, GERMAN, JAPANESE, SPANISH, SYNONYM }

final titleTypeValues = EnumValues({
  "Default": TitleType.DEFAULT,
  "English": TitleType.ENGLISH,
  "French": TitleType.FRENCH,
  "German": TitleType.GERMAN,
  "Japanese": TitleType.JAPANESE,
  "Spanish": TitleType.SPANISH,
  "Synonym": TitleType.SYNONYM
});

class Pagination {
  final int? lastVisiblePage;
  final bool? hasNextPage;
  final int? currentPage;
  final Items? items;

  Pagination({
    this.lastVisiblePage,
    this.hasNextPage,
    this.currentPage,
    this.items,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        lastVisiblePage: json["last_visible_page"],
        hasNextPage: json["has_next_page"],
        currentPage: json["current_page"],
        items: json["items"] == null ? null : Items.fromJson(json["items"]),
      );

  Map<String, dynamic> toJson() => {
        "last_visible_page": lastVisiblePage,
        "has_next_page": hasNextPage,
        "current_page": currentPage,
        "items": items?.toJson(),
      };
}

class Items {
  final int? count;
  final int? total;
  final int? perPage;

  Items({
    this.count,
    this.total,
    this.perPage,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        count: json["count"],
        total: json["total"],
        perPage: json["per_page"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "total": total,
        "per_page": perPage,
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
