import 'package:cloud_firestore/cloud_firestore.dart';

class MylistModel {
  final int malId;
  final String animeOrManga;
  final String imageUrl;
  final String title;
  final String type;
  final String? userStatus;
  final String? airingStart;
  final int? episodesOrChapters;
  int userProgress;
  final int? userScore;
  final String? userStartDate;
  final String? userEndDate;
  final Timestamp addedTime;

  MylistModel({
    required this.malId,
    required this.animeOrManga,
    required this.imageUrl,
    required this.title,
    required this.type,
    required this.userStatus,
    required this.airingStart,
    required this.episodesOrChapters,
    required userProgress,
    required this.userScore,
    required this.userStartDate,
    required this.userEndDate,
    required addedTime,
  })  : addedTime = addedTime ?? Timestamp.now(),
        userProgress = userProgress ?? 0;

  factory MylistModel.fromMap(Map<String, dynamic> json) {
    return MylistModel(
      malId: json['malId'],
      animeOrManga: json['animeOrManga'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      type: json['type'],
      userStatus: json['userStatus'],
      airingStart: json['airingStart'],
      episodesOrChapters: json['episodesOrChapters'],
      userProgress: json['userProgress'],
      userScore: json['userScore'],
      userStartDate: json['userStartDate'],
      userEndDate: json['userEndDate'],
      addedTime: json['addedTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'malId': malId,
      'animeOrManga': animeOrManga,
      'imageUrl': imageUrl,
      'title': title,
      'type': type,
      'userStatus': userStatus,
      'airingStart': airingStart,
      'episodesOrChapters': episodesOrChapters,
      'userProgress': userProgress,
      'userScore': userScore,
      'userStartDate': userStartDate,
      'userEndDate': userEndDate,
      'addedTime': addedTime,
    };
  }

  copyWith({
    int? malId,
    String? animeOrManga,
    String? imageUrl,
    String? title,
    String? type,
    String? userStatus,
    String? airingStart,
    int? episodesOrChapters,
    int? userProgress,
    int? userScore,
    String? userStartDate,
    String? userEndDate,
  }) {
    return MylistModel(
      malId: malId ?? this.malId,
      animeOrManga: animeOrManga ?? this.animeOrManga,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      type: type ?? this.type,
      userStatus: userStatus ?? this.userStatus,
      airingStart: airingStart ?? this.airingStart,
      episodesOrChapters: episodesOrChapters ?? this.episodesOrChapters,
      userProgress: userProgress ?? this.userProgress,
      userScore: userScore ?? this.userScore,
      userStartDate: userStartDate ?? this.userStartDate,
      userEndDate: userEndDate ?? this.userEndDate,
      addedTime: Timestamp.now(),
    );
  }
}
