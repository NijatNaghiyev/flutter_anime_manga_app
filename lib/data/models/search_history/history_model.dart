import 'package:cloud_firestore/cloud_firestore.dart';

class SearchHistoryModel {
  final String history;
  final Timestamp time;

  SearchHistoryModel({
    required this.history,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'history': history,
      'time': time,
    };
  }

  factory SearchHistoryModel.fromMap(Map<String, dynamic> json) {
    return SearchHistoryModel(
      history: json['history'] as String,
      time: json['time'] as Timestamp,
    );
  }
}
