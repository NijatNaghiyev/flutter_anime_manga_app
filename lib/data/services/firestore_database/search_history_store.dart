import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_anime_manga_app/data/models/search_history/history_model.dart';

class SearchHistoryStore {
  /// Save search history to firestore
  static Future<void> saveHistory({required String history}) async {
    List<SearchHistoryModel> searchHistoryList = await getHistory();
    final firestore = FirebaseFirestore.instance;
    final authCredential = FirebaseAuth.instance.currentUser;

    searchHistoryList.add(SearchHistoryModel(
      history: history,
      time: Timestamp.now(),
    ));

    /// Remove the oldest history if the list is more than 25
    if (searchHistoryList.length > 25) {
      searchHistoryList.sort((a, b) => b.time.compareTo(a.time));
      searchHistoryList.removeLast();
    }

    await firestore
        .collection('${authCredential!.email}')
        .doc('searchHistory')
        .set({
      'historyList': searchHistoryList.map((e) => e.toJson()).toList(),
    });
  }

  /// Get search history from firestore
  static Future<List<SearchHistoryModel>> getHistory() async {
    final firestore = FirebaseFirestore.instance;
    final authCredential = FirebaseAuth.instance.currentUser;
    final historyRef = await firestore
        .collection('${authCredential!.email}')
        .doc('searchHistory')
        .get();
    if (!historyRef.exists) {
      return [];
    }
    final historyList = historyRef.data()!['historyList'] as List;
    return historyList
        .map((e) => SearchHistoryModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  /// Clear search history from firestore
  static Future<void> clearHistory() async {
    final firestore = FirebaseFirestore.instance;
    final authCredential = FirebaseAuth.instance.currentUser;
    await firestore
        .collection('${authCredential!.email}')
        .doc('searchHistory')
        .delete();
  }
}
