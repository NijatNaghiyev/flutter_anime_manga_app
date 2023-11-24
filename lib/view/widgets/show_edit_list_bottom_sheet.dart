import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/data/services/firestore_database/mylist_anime_store.dart';

import '../../constants/enum/search_type.dart';
import '../../data/models/mylist/mylist_model.dart';
import '../../data/services/firestore_database/mylist_manga_store.dart';
import 'edit_list_bottom_sheet.dart';

/// Show [EditListBottomSheet] as a modal bottom sheet.
Future<void> showEditListBottomSheet(
    {required BuildContext context,
    required SearchType type,
    required MylistModel mylistModel}) async {
  List<MylistModel> myList = [];
  if (type == SearchType.anime) {
    myList = await MylistAnimeStore.getMylist();
  } else if (type == SearchType.manga) {
    myList = await MylistMangaStore.getMylist();
  }

  await showModalBottomSheet(
    useRootNavigator: true,
    enableDrag: true,
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (context) => EditListBottomSheet(
      type: type,
      mylistModel: myList
              .where((element) => element.malId == mylistModel.malId)
              .isEmpty
          ? mylistModel
          : myList.where((element) => element.malId == mylistModel.malId).first,
    ),
  );
}
