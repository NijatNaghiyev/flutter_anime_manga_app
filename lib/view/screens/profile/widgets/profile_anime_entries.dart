import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';

import '../../../../data/models/mylist/mylist_model.dart';
import '../../../../data/services/firestore_database/mylist_anime_store.dart';

class ProfileAnimeEntries extends StatefulWidget {
  const ProfileAnimeEntries({super.key});

  @override
  State<ProfileAnimeEntries> createState() => _ProfileAnimeEntriesState();
}

class _ProfileAnimeEntriesState extends State<ProfileAnimeEntries> {
  ValueNotifier<List<MylistModel>> mylist = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    MylistAnimeStore.getMylist().then((value) {
      mylist.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: mylist,
      builder: (context, value, _) {
        if (value.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 110,
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        children: [
                          Text('Anime'),
                          Text(''),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Completed'),
                          Text(
                            value
                                .where((element) =>
                                    element.userStatus == 'Completed')
                                .length
                                .toString(),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Mean Score'),
                          Text(
                            (value.fold<num>(0, (previousValue, element) {
                                      if (element.userScore == null) {
                                        return previousValue;
                                      }
                                      return previousValue + element.userScore!;
                                    }) /
                                    value
                                        .where((element) =>
                                            element.userScore != null)
                                        .length)
                                .toStringAsFixed(2),
                          ),
                        ],
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: value
                            .where(
                                (element) => element.userStatus == 'Completed')
                            .length /
                        value.length,
                    color: MyColors.animeTypeColor,
                    minHeight: 20,
                  ),
                  const SizedBox(height: 10),
                  Text('${value.length} Anime List Entries'),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
