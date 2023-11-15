// To parse this JSON data, do
//
//     final statisticsAnimeModel = statisticsAnimeModelFromJson(jsonString);

import 'dart:convert';

StatisticsAnimeModel statisticsAnimeModelFromJson(String str) =>
    StatisticsAnimeModel.fromJson(json.decode(str));

String statisticsAnimeModelToJson(StatisticsAnimeModel data) =>
    json.encode(data.toJson());

class StatisticsAnimeModel {
  final int? watching;
  final int? completed;
  final int? onHold;
  final int? dropped;
  final int? planToWatch;
  final int? total;
  final List<Score>? scores;

  StatisticsAnimeModel({
    this.watching,
    this.completed,
    this.onHold,
    this.dropped,
    this.planToWatch,
    this.total,
    this.scores,
  });

  factory StatisticsAnimeModel.fromJson(Map<String, dynamic> json) =>
      StatisticsAnimeModel(
        watching: json["watching"],
        completed: json["completed"],
        onHold: json["on_hold"],
        dropped: json["dropped"],
        planToWatch: json["plan_to_watch"],
        total: json["total"],
        scores: json["scores"] == null
            ? []
            : List<Score>.from(json["scores"]!.map((x) => Score.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "watching": watching,
        "completed": completed,
        "on_hold": onHold,
        "dropped": dropped,
        "plan_to_watch": planToWatch,
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
