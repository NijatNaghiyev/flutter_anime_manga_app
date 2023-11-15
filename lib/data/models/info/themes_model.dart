// To parse this JSON data, do
//
//     final themesModel = themesModelFromJson(jsonString);

import 'dart:convert';

ThemesModel themesModelFromJson(String str) =>
    ThemesModel.fromJson(json.decode(str));

String themesModelToJson(ThemesModel data) => json.encode(data.toJson());

class ThemesModel {
  final List<String>? openings;
  final List<String>? endings;

  ThemesModel({
    this.openings,
    this.endings,
  });

  factory ThemesModel.fromJson(Map<String, dynamic> json) => ThemesModel(
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
