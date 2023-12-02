import 'package:flutter/material.dart';

import '../../../../constants/edit_list_bottom_sheet/status_anime.dart';
import '../../../../constants/edit_list_bottom_sheet/status_colors.dart';
import '../../../../constants/enum/search_type.dart';
import '../../../../constants/theme/colors.dart';
import '../../../../data/models/anime/anime_full_model.dart';
import '../../../../data/models/mylist/mylist_model.dart';
import '../../../../data/services/firestore_database/mylist_anime_store.dart';
import '../../../widgets/show_edit_list_bottom_sheet.dart';

class InfoFAB extends StatelessWidget {
  const InfoFAB({
    super.key,
    required this.data,
    required this.mylistValueNotifier,
    required this.value,
    required this.searchType,
  });

  final Data data;
  final ValueNotifier<List<MylistModel>?> mylistValueNotifier;
  final List<MylistModel> value;
  final SearchType searchType;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await showEditListBottomSheet(
          context: context,
          type: searchType,
          mylistModel: MylistModel(
            malId: data.malId!,
            animeOrManga: searchType.name,
            imageUrl: data.images!['jpg']!.imageUrl!,
            title: data.title!,
            type: data.type!,
            userStatus: value.any((element) => element.malId == data.malId)
                ? value
                    .firstWhere((element) => element.malId == data.malId)
                    .userStatus!
                : null,
            airingStart: data.aired!.string!,
            episodesOrChapters: data.episodes,
            userProgress: null,
            userScore: null,
            userStartDate: null,
            userEndDate: null,
            addedTime: null,
          ),
        );
        await MylistAnimeStore.getMylist()
            .then((value) => mylistValueNotifier.value = value);
      },
      backgroundColor: value.any((element) => element.malId == data.malId)
          ? StatusColors.statusColors[StatusAnime.statusList.indexOf(value
              .firstWhere((element) => element.malId == data.malId)
              .userStatus!)]
          : MyColors.primary,
      child: const Icon(
        Icons.edit_note,
        color: Colors.white,
        size: 32,
      ),
    );
  }
}
