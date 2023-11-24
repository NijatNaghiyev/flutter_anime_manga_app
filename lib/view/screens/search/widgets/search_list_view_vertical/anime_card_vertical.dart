import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anime_manga_app/constants/enum/search_type.dart';
import 'package:flutter_anime_manga_app/data/models/mylist/mylist_model.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_filter_row.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/edit_list_bottom_sheet/status_anime.dart';
import '../../../../../constants/edit_list_bottom_sheet/status_colors.dart';
import '../../../../../constants/theme/colors.dart';
import '../../../../../data/services/firestore_database/mylist_anime_store.dart';
import '../../../../widgets/show_edit_list_bottom_sheet.dart';
import '../../../info/info_screen.dart';

class AnimeCardVertical extends StatefulWidget {
  const AnimeCardVertical({
    super.key,
    required this.index,
    this.imageUrl,
    required this.title,
    required this.type,
    this.episodes,
    this.aired,
    this.scoredBy,
    required this.searchType,
    this.scored,
    required this.malId,
    this.isSearch = true,
  });

  final bool isSearch;

  final int malId;
  final SearchType searchType;
  final int index;
  final String? imageUrl;
  final String title;
  final String type;
  final int? episodes;
  final String? aired;
  final int? scoredBy;
  final double? scored;

  @override
  State<AnimeCardVertical> createState() => _AnimeCardVerticalState();
}

class _AnimeCardVerticalState extends State<AnimeCardVertical> {
  final formatter = NumberFormat('#,###,###');
  ValueNotifier<List<MylistModel>> mylistValueNotifier = ValueNotifier([]);

  void initData() async {
    await MylistAnimeStore.getMylist()
        .then((value) => mylistValueNotifier.value = value);
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (context, action) {
        return InfoScreen(
          malId: widget.malId,
          type: widget.searchType,
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
      closedBuilder: (context, action) => Column(
        children: [
          if (widget.index == 0 && widget.isSearch) const SearchFilterRow(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.18,
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Row(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.18,
                    width: MediaQuery.sizeOf(context).width * 0.2,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          widget.imageUrl.toString(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.red,
                              ),
                            );
                          },
                        ),
                        if (widget.scored != null)
                          Positioned(
                            bottom: MediaQuery.sizeOf(context).height * 0.01,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    widget.scored.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 13,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: widget.searchType == SearchType.anime
                                      ? MyColors.animeTypeColor
                                      : MyColors.mangaTypeColor,
                                ),
                                height: 25.0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 3,
                                ),
                                child: Center(
                                  child: Text(
                                    widget.type,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.episodes ?? '??'} ${widget.searchType == SearchType.anime ? 'ep' : 'chp'}, ${widget.aired ?? ''}',
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (widget.scoredBy != null)
                          Row(
                            children: [
                              Text(
                                formatter.format(widget.scoredBy),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.people,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ValueListenableBuilder(
                    valueListenable: mylistValueNotifier,
                    builder: (context, value, _) {
                      return IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () async {
                          /// Show bottom sheet
                          await showEditListBottomSheet(
                            context: context,
                            type: widget.searchType,
                            mylistModel: MylistModel(
                              malId: widget.malId,
                              animeOrManga: widget.searchType.name,
                              imageUrl: widget.imageUrl ?? '',
                              title: widget.title,
                              type: widget.type,
                              userStatus: null,
                              airingStart: widget.aired,
                              episodesOrChapters: widget.episodes,
                              userProgress: null,
                              userScore: null,
                              userStartDate: null,
                              userEndDate: null,
                              addedTime: null,
                            ),
                          );
                          initData();
                        },
                        icon: Icon(
                          Icons.add_box_outlined,
                          color: value.any(
                                  (element) => element.malId == widget.malId)
                              ? StatusColors.statusColors[StatusAnime.statusList
                                  .indexOf(value
                                      .firstWhere((element) =>
                                          element.malId == widget.malId)
                                      .userStatus!)]
                              : Colors.white,
                          size: 32,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
