import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_anime_manga_app/data/models/mylist/mylist_model.dart';

class MylistMangaStore {
  /// Save mylist to firestore
  static Future<void> saveMylist({required MylistModel mylistModel}) async {
    final firestore = FirebaseFirestore.instance;
    final authCredential = FirebaseAuth.instance.currentUser;
    List<MylistModel> mylist = await getMylist();

    /// If the anime is in List, then update it
    for (MylistModel element in mylist) {
      if (element.malId == mylistModel.malId) {
        mylist.replaceRange(mylist.indexOf(element),
            mylist.indexOf(element) + 1, [mylistModel]);
      }
    }

    /// If the anime is not in List, then add it
    if (mylist
        .where((element) => element.malId == mylistModel.malId)
        .toList()
        .isEmpty) {
      mylist.add(mylistModel);
    }

    await firestore
        .collection('${authCredential!.email}')
        .doc('mylistManga')
        .set({
      'mylistManga': mylist.map((e) => e.toJson()).toList(),
    });
  }

  /// Get mylist from firestore
  static Future<List<MylistModel>> getMylist() async {
    final firestore = FirebaseFirestore.instance;
    final authCredential = FirebaseAuth.instance.currentUser;

    final mylistRef = await firestore
        .collection('${authCredential!.email}')
        .doc('mylistManga')
        .get();
    if (!mylistRef.exists) {
      return [];
    }

    if (mylistRef.data()!['mylistManga'] == null) {
      return [];
    }

    final myList = mylistRef.data()!['mylistManga'] as List;
    return myList
        .map((e) => MylistModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  /// Delete mylist from firestore
  static Future<void> deleteMylist({required MylistModel mylistModel}) async {
    final firestore = FirebaseFirestore.instance;
    final authCredential = FirebaseAuth.instance.currentUser;
    List<MylistModel> mylist = await getMylist();

    /// If the manga is already in the list, remove it and add it again
    mylist =
        mylist.where((element) => element.malId != mylistModel.malId).toList();

    await firestore
        .collection('${authCredential!.email}')
        .doc('mylistManga')
        .set({
      'mylistManga': mylist.map((e) => e.toJson()).toList(),
    });
  }
}
