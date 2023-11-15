// To parse this JSON data, do
//
//     final charactersSearchModel = charactersSearchModelFromJson(jsonString);

import 'dart:convert';

CharactersSearchModel charactersSearchModelFromJson(String str) =>
    CharactersSearchModel.fromJson(json.decode(str));

String charactersSearchModelToJson(CharactersSearchModel data) =>
    json.encode(data.toJson());

class CharactersSearchModel {
  final Pagination? pagination;
  final List<CharactersDatum> data;

  CharactersSearchModel({
    required this.pagination,
    required this.data,
  });

  factory CharactersSearchModel.fromJson(Map<String, dynamic> json) =>
      CharactersSearchModel(
        pagination: Pagination.fromJson(json["pagination"]),
        data: List<CharactersDatum>.from(
            json["data"].map((x) => CharactersDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CharactersDatum {
  final int malId;
  final String url;
  final Images images;
  final String name;
  final String? nameKanji;
  final List<String> nicknames;
  final int favorites;
  final String? about;

  CharactersDatum({
    required this.malId,
    required this.url,
    required this.images,
    required this.name,
    required this.nameKanji,
    required this.nicknames,
    required this.favorites,
    required this.about,
  });

  factory CharactersDatum.fromJson(Map<String, dynamic> json) =>
      CharactersDatum(
        malId: json["mal_id"],
        url: json["url"],
        images: Images.fromJson(json["images"]),
        name: json["name"],
        nameKanji: json["name_kanji"],
        nicknames: List<String>.from(json["nicknames"].map((x) => x)),
        favorites: json["favorites"],
        about: json["about"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": images.toJson(),
        "name": name,
        "name_kanji": nameKanji,
        "nicknames": List<dynamic>.from(nicknames.map((x) => x)),
        "favorites": favorites,
        "about": about,
      };
}

class Images {
  final Jpg jpg;
  final Webp webp;

  Images({
    required this.jpg,
    required this.webp,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        jpg: Jpg.fromJson(json["jpg"]),
        webp: Webp.fromJson(json["webp"]),
      );

  Map<String, dynamic> toJson() => {
        "jpg": jpg.toJson(),
        "webp": webp.toJson(),
      };
}

class Jpg {
  final String imageUrl;

  Jpg({
    required this.imageUrl,
  });

  factory Jpg.fromJson(Map<String, dynamic> json) => Jpg(
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
      };
}

class Webp {
  final String imageUrl;
  final String smallImageUrl;

  Webp({
    required this.imageUrl,
    required this.smallImageUrl,
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

class Pagination {
  final int lastVisiblePage;
  final bool hasNextPage;
  final int currentPage;
  final Items items;

  Pagination({
    required this.lastVisiblePage,
    required this.hasNextPage,
    required this.currentPage,
    required this.items,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        lastVisiblePage: json["last_visible_page"],
        hasNextPage: json["has_next_page"],
        currentPage: json["current_page"],
        items: Items.fromJson(json["items"]),
      );

  Map<String, dynamic> toJson() => {
        "last_visible_page": lastVisiblePage,
        "has_next_page": hasNextPage,
        "current_page": currentPage,
        "items": items.toJson(),
      };
}

class Items {
  final int count;
  final int total;
  final int perPage;

  Items({
    required this.count,
    required this.total,
    required this.perPage,
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
