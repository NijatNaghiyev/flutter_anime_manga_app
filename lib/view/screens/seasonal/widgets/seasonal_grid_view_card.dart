import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/data/models/mylist/mylist_model.dart';
import 'package:intl/intl.dart';

import '../../../../constants/edit_list_bottom_sheet/status_anime.dart';
import '../../../../constants/edit_list_bottom_sheet/status_colors.dart';
import '../../../../constants/enum/search_type.dart';
import '../../../../data/models/seasonal/seasonal_model.dart';
import '../../../../data/services/firestore_database/mylist_anime_store.dart';
import '../../../info/info_screen.dart';
import '../../../widgets/edit_list_bottom_sheet.dart';

class SeasonalGridViewCard extends StatefulWidget {
  const SeasonalGridViewCard(
      {super.key, required this.data, required this.animeList});

  final SeasonalData data;
  final List<MylistModel> animeList;

  @override
  State<SeasonalGridViewCard> createState() => _SeasonalGridViewCardState();
}

class _SeasonalGridViewCardState extends State<SeasonalGridViewCard> {
  ValueNotifier<List<MylistModel>> animeListValueNotifier = ValueNotifier([]);

  void animeListGet() async {
    animeListValueNotifier.value = widget.animeList;
  }

  @override
  void initState() {
    super.initState();
    animeListGet();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###,###');

    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (context, action) {
        return InfoScreen(
          malId: widget.data.malId,
          type: SearchType.anime,
        );
      },
      clipBehavior: Clip.hardEdge,
      closedColor: Colors.transparent,
      closedElevation: 0,
      // * important
      useRootNavigator: true,
      onClosed: (data) {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      },
      closedBuilder: (context, action) => Card(
        color: MyColors.primary.withOpacity(0.5),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.network(
                      widget.data.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.4,
                    ),
                    Positioned(
                      bottom: 2,
                      right: 8,
                      left: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.data.score == null
                                            ? 'N/A'
                                            : widget.data.score.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.star,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        formatter
                                            .format(widget.data.members)
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.people,
                                        size: 14,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await showEditListBottomSheet(
                                context: context,
                                type: SearchType.anime,
                                mylistModel: animeListValueNotifier.value.any(
                                        (element) =>
                                            element.malId == widget.data.malId)
                                    ? animeListValueNotifier.value.firstWhere(
                                        (element) =>
                                            element.malId == widget.data.malId)
                                    : MylistModel(
                                        malId: widget.data.malId,
                                        animeOrManga: SearchType.anime.name,
                                        imageUrl: widget.data.imageUrl,
                                        title: widget.data.title,
                                        type: widget.data.type,
                                        userStatus: null,
                                        airingStart: widget.data.aired,
                                        episodesOrChapters:
                                            widget.data.episodes,
                                        userProgress: null,
                                        userScore: null,
                                        userStartDate: null,
                                        userEndDate: null,
                                        addedTime: null,
                                      ),
                              );
                              animeListValueNotifier.value =
                                  await MylistAnimeStore.getMylist();
                            },
                            child: ValueListenableBuilder(
                                valueListenable: animeListValueNotifier,
                                builder: (context, value, _) {
                                  return Container(
                                    padding: const EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Icon(
                                      color: value.any((element) =>
                                              element.malId ==
                                              widget.data.malId)
                                          ? StatusColors.statusColors[
                                              StatusAnime.statusList.indexOf(
                                                  value
                                                      .firstWhere((element) =>
                                                          element.malId ==
                                                          widget.data.malId)
                                                      .userStatus!)]
                                          : Colors.white,
                                      Icons.edit_note,
                                      size: 32,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.data.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.data.genres.join(', '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .color
                              ?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
