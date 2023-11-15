import 'dart:convert';

TopPeopleModel topPeopleModelFromJson(String str) =>
    TopPeopleModel.fromJson(json.decode(str));

String topPeopleModelToJson(TopPeopleModel data) => json.encode(data.toJson());

class TopPeopleModel {
  final Pagination pagination;
  final List<Datum> data;

  TopPeopleModel({
    required this.pagination,
    required this.data,
  });

  factory TopPeopleModel.fromJson(Map<String, dynamic> json) => TopPeopleModel(
        pagination: Pagination.fromJson(json["pagination"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int malId;
  final String url;
  final String? websiteUrl;
  final Images images;
  final String name;
  final String givenName;
  final String familyName;
  final List<String> alternateNames;
  final DateTime birthday;
  final int favorites;
  final String about;

  Datum({
    required this.malId,
    required this.url,
    required this.websiteUrl,
    required this.images,
    required this.name,
    required this.givenName,
    required this.familyName,
    required this.alternateNames,
    required this.birthday,
    required this.favorites,
    required this.about,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        malId: json["mal_id"],
        url: json["url"],
        websiteUrl: json["website_url"],
        images: Images.fromJson(json["images"]),
        name: json["name"],
        givenName: json["given_name"],
        familyName: json["family_name"],
        alternateNames:
            List<String>.from(json["alternate_names"].map((x) => x)),
        birthday: DateTime.parse(json["birthday"]),
        favorites: json["favorites"],
        about: json["about"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "website_url": websiteUrl,
        "images": images.toJson(),
        "name": name,
        "given_name": givenName,
        "family_name": familyName,
        "alternate_names": List<dynamic>.from(alternateNames.map((x) => x)),
        "birthday": birthday.toIso8601String(),
        "favorites": favorites,
        "about": about,
      };
}

class Images {
  final Jpg jpg;

  Images({
    required this.jpg,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        jpg: Jpg.fromJson(json["jpg"]),
      );

  Map<String, dynamic> toJson() => {
        "jpg": jpg.toJson(),
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
