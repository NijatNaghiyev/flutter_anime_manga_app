import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';

import '../../../../constants/edit_list_bottom_sheet/status_anime.dart';
import '../../../../constants/edit_list_bottom_sheet/status_manga.dart';
import '../../../../constants/enum/search_type.dart';
import 'mylist_app_bar_switch.dart';

class BottomStatus extends StatelessWidget {
  const BottomStatus({super.key, required this.tabController});

  final TabController tabController;

  List<Tab> mylistTabs({required SearchType type}) {
    if (type == SearchType.anime) {
      return [
        ...[
          const Tab(
            text: 'All',
          )
        ],
        ...StatusAnime.statusList.map(
          (e) {
            return Tab(
              text: e,
            );
          },
        )
      ];
    } else if (type == SearchType.manga) {
      return [
        ...[
          const Tab(
            text: 'All',
          )
        ],
        ...StatusManga.statusList.map(
          (e) {
            return Tab(
              text: e,
            );
          },
        )
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: animeOrManga,
      builder: (context, type, _) {
        print(type);
        return TabBar(
          indicatorColor: MyColors.primary,
          labelColor: Theme.of(context).textTheme.bodySmall!.color,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor:
              Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.6),
          physics: const BouncingScrollPhysics(),
          isScrollable: true,
          controller: tabController,
          tabs: mylistTabs(type: type),
        );
      },
    );
  }
}
