// To parse this JSON data, do
//
//     final statisticsMangaModel = statisticsMangaModelFromJson(jsonString);

import 'dart:convert';

StatisticsMangaModel statisticsMangaModelFromJson(String str) =>
    StatisticsMangaModel.fromJson(json.decode(str));

String statisticsMangaModelToJson(StatisticsMangaModel data) =>
    json.encode(data.toJson());

class StatisticsMangaModel {
  final int? reading;
  final int? completed;
  final int? onHold;
  final int? dropped;
  final int? planToRead;
  final int? total;
  final List<Score>? scores;

  StatisticsMangaModel({
    this.reading,
    this.completed,
    this.onHold,
    this.dropped,
    this.planToRead,
    this.total,
    this.scores,
  });

  factory StatisticsMangaModel.fromJson(Map<String, dynamic> json) =>
      StatisticsMangaModel(
        reading: json["reading"],
        completed: json["completed"],
        onHold: json["on_hold"],
        dropped: json["dropped"],
        planToRead: json["plan_to_read"],
        total: json["total"],
        scores: json["scores"] == null
            ? []
            : List<Score>.from(json["scores"]!.map((x) => Score.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reading": reading,
        "completed": completed,
        "on_hold": onHold,
        "dropped": dropped,
        "plan_to_read": planToRead,
        "total": total,
        "scores": scores == null
            ? []
            : List<dynamic>.from(scores!.map((x) => x.toJson())),
      };
}

class Score {
  final int? score;
  final int? votes;
  final double? percentage;

  Score({
    this.score,
    this.votes,
    this.percentage,
  });

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        score: json["score"],
        votes: json["votes"],
        percentage: json["percentage"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "votes": votes,
        "percentage": percentage,
      };
}
