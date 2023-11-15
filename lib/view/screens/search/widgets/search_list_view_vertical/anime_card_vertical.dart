import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anime_manga_app/constants/enum/search_type.dart';
import 'package:flutter_anime_manga_app/data/models/mylist/mylist_model.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_filter_row.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/theme/colors.dart';
import '../../../../info/info_screen.dart';
import '../../../../widgets/edit_list_bottom_sheet.dart';

class AnimeCardVertical extends StatelessWidget {
  AnimeCardVertical({
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

  final formatter = NumberFormat('#,###,###');

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (context, action) {
        return InfoScreen(
          malId: malId,
          type: searchType,
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
          if (index == 0 && isSearch) const SearchFilterRow(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.15,
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Row(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.15,
                    width: MediaQuery.sizeOf(context).width * 0.2,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          imageUrl.toString(),
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
                        if (scored != null)
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
                                    scored.toString(),
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
                          title,
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
                                  color: searchType == SearchType.anime
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
                                    type,
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
                              '${episodes ?? '??'} ${searchType == SearchType.anime ? 'ep' : 'chp'}, ${aired ?? ''}',
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (scoredBy != null)
                          Row(
                            children: [
                              Text(
                                formatter.format(scoredBy),
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
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      /// Show bottom sheet
                      showEditListBottomSheet(
                        context: context,
                        type: searchType,
                        mylistModel: MylistModel(
                          malId: malId,
                          animeOrManga: searchType.name,
                          imageUrl: imageUrl ?? '',
                          title: title,
                          type: type,
                          userStatus: null,
                          airingStart: aired,
                          episodesOrChapters: episodes,
                          userProgress: null,
                          userScore: null,
                          userStartDate: null,
                          userEndDate: null,
                          addedTime: null,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add_box_outlined,
                      size: 32,
                    ),
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
