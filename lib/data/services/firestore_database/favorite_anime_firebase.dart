import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_anime_manga_app/data/models/info/favorite_model.dart';

import '../../../view/info/widgets/favorite_icon_value_listenable.dart';

class FavoriteAnimeFirebaseService {
  static Future<void> addOrRemoveFavorite(
      {required FavoriteModel favoriteModel}) async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    List<FavoriteModel> favoriteAnimeList = await getFavoriteAnimeList();

    /// Check if the anime is in List, then update it or remove it
    if (favoriteAnimeList
        .where((element) => element.malId == favoriteModel.malId)
        .toList()
        .isEmpty) {
      favoriteAnimeList.add(favoriteModel);
    } else {
      favoriteAnimeList = favoriteAnimeList
          .where((element) => element.malId != favoriteModel.malId)
          .toList()
          .cast<FavoriteModel>();
    }
    favoriteAnimeMangaListValueNotifier.value = {
      'anime': favoriteAnimeList.cast<FavoriteModel>(),
      'manga': favoriteAnimeMangaListValueNotifier.value['manga']!,
    };
    await firestore
        .collection(user!.email.toString())
        .doc('favoriteAnime')
        .set({
      'favoriteAnimeList': favoriteAnimeList.map((e) => e.toJson()).toList(),
    });
  }

  static Future<List<FavoriteModel>> getFavoriteAnimeList() async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    final favoriteAnimeRef = await firestore
        .collection(user!.email.toString())
        .doc('favoriteAnime')
        .get();

    if (!favoriteAnimeRef.exists) {
      return [];
    }

    if (favoriteAnimeRef.data()!['favoriteAnimeList'] == null) {
      return [];
    }

    final list = favoriteAnimeRef.data()!['favoriteAnimeList'] as List;

    return list
        .map((e) => FavoriteModel.fromJson(e as Map<String, dynamic>))
        .toList()
        .cast<FavoriteModel>();
  }
}
