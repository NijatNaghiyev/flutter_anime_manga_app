import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_anime_manga_app/data/models/info/favorite_model.dart';

import '../../../view/info/widgets/favorite_icon_value_listenable.dart';

class FavoriteMangaFirebaseService {
  static Future<void> addOrRemoveFavorite(
      {required FavoriteModel favoriteModel}) async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    List<FavoriteModel> favoriteMangaList = await getFavoriteMangaList();

    /// Check if the Manga is in List, then update it or remove it
    if (favoriteMangaList
        .where((element) => element.malId == favoriteModel.malId)
        .toList()
        .isEmpty) {
      favoriteMangaList.add(favoriteModel);
    } else {
      favoriteMangaList = favoriteMangaList
          .where((element) => element.malId != favoriteModel.malId)
          .toList()
          .cast<FavoriteModel>();
    }

    favoriteAnimeMangaListValueNotifier.value = {
      'anime': favoriteAnimeMangaListValueNotifier.value['anime']!,
      'manga': favoriteMangaList.cast<FavoriteModel>(),
    };

    await firestore
        .collection(user!.email.toString())
        .doc('favoriteManga')
        .set({
      'favoriteMangaList': favoriteMangaList.map((e) => e.toJson()).toList(),
    });
  }

  static Future<List<FavoriteModel>> getFavoriteMangaList() async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    final favoriteMangaRef = await firestore
        .collection(user!.email.toString())
        .doc('favoriteManga')
        .get();

    if (!favoriteMangaRef.exists) {
      return [];
    }

    if (favoriteMangaRef.data()!['favoriteMangaList'] == null) {
      return [];
    }

    final list = favoriteMangaRef.data()!['favoriteMangaList'] as List;

    return list
        .map((e) => FavoriteModel.fromJson(e as Map<String, dynamic>))
        .toList()
        .cast<FavoriteModel>();
  }
}
