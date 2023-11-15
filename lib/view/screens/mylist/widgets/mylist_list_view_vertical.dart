import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/edit_list_bottom_sheet/status_anime.dart';
import 'package:flutter_anime_manga_app/constants/enum/search_type.dart';
import 'package:flutter_anime_manga_app/view/screens/mylist/widgets/mylist_list_view_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/edit_list_bottom_sheet/status_manga.dart';
import '../../../../constants/theme/colors.dart';
import '../../../../data/models/mylist/mylist_model.dart';
import '../../../../features/state/bloc/mylist_screen/anime_list/mylist_anime_bloc.dart';
import '../../../../features/state/bloc/mylist_screen/manga_list/mylist_manga_bloc.dart';

class MyListListViewVertical extends StatefulWidget {
  const MyListListViewVertical({
    super.key,
    required this.animeMangaList,
    required this.type,
    required this.indexTab,
  });

  final SearchType type;
  final List<MylistModel> animeMangaList;
  final int indexTab;

  @override
  State<MyListListViewVertical> createState() => _MyListListViewVerticalState();
}

class _MyListListViewVerticalState extends State<MyListListViewVertical>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    /// User status
    final String userStatus = widget.type == SearchType.anime
        ? StatusAnime.statusList[widget.indexTab == 0 ? 0 : widget.indexTab - 1]
        : StatusManga
            .statusList[widget.indexTab == 0 ? 0 : widget.indexTab - 1];

    final List<MylistModel> myList = widget.indexTab == 0
        ? widget.animeMangaList
        : widget.animeMangaList
            .where(
              (element) => element.userStatus == userStatus,
            )
            .toList();

    return Column(
      children: [
        /// Statistics
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.bar_chart),
              label: Text(
                '${myList.length} Entries',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            PopupMenuButton<int>(
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<int>>[
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(
                      'Sort by Title',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text(
                      'Sort by Score',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text(
                      'Sort by Progress',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 3,
                    child: Text(
                      'Sort by Start Date',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 4,
                    child: Row(
                      children: [
                        Text(
                          'Sort by End Date',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              child: const Icon(Icons.filter_list),
            ),
            const SizedBox(width: 8),
          ],
        ),
        // ! Don't remove Expanded
        Expanded(
          child: RefreshIndicator(
            color: MyColors.primary,
            onRefresh: () {
              if (widget.type == SearchType.anime) {
                context.read<MylistAnimeBloc>().add(
                      const MylistAnimeLoadEvent(),
                    );
              } else if (widget.type == SearchType.manga) {
                context.read<MylistMangaBloc>().add(
                      const MylistMangaLoadEvent(),
                    );
              }
              return Future<void>.value();
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: myList.length,
              itemBuilder: (context, index) {
                final data = myList[index];
                return MylistListViewCard(
                  data: data,
                  type: widget.type,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
