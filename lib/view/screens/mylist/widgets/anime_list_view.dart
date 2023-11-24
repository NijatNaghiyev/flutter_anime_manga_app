import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/features/state/bloc/mylist_screen/anime_list/mylist_anime_bloc.dart';
import 'package:flutter_anime_manga_app/view/screens/mylist/widgets/bottom_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/enum/search_type.dart';
import '../../../widgets/center_loading_indicator.dart';
import 'mylist_list_view_vertical.dart';

class AnimeListView extends StatefulWidget {
  const AnimeListView({super.key});

  @override
  State<AnimeListView> createState() => _AnimeListViewState();
}

class _AnimeListViewState extends State<AnimeListView>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  bool isDialogOpen = false;

  /// Close dialog if open
  void closeDialog() {
    if (isDialogOpen) {
      isDialogOpen = false;
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this, initialIndex: 0);

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('anime_list_view'),
      body: BlocConsumer<MylistAnimeBloc, MylistAnimeState>(
        buildWhen: (previous, current) => current is! MylistAnimeStateAction,
        listenWhen: (previous, current) => current is MylistAnimeStateAction,
        listener: (context, state) {
          isDialogOpen = true;
          showGeneralDialog(
            barrierDismissible: false,
            useRootNavigator: false,
            barrierColor: Colors.transparent,
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const CenterLoadingIndicator(),
          );
        },
        builder: (context, state) {
          if (state is MylistAnimeLoad) {
            log('MylistAnimeLoad');

            closeDialog();

            final data = state as MylistAnimeLoad;
            return Column(
              children: [
                BottomStatus(tabController: tabController),
                Expanded(
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    controller: tabController,
                    children: <Widget>[
                      MyListListViewVertical(
                        type: SearchType.anime,
                        animeMangaList: data.animeList,
                        indexTab: 0,
                      ),
                      MyListListViewVertical(
                        type: SearchType.anime,
                        animeMangaList: data.animeList,
                        indexTab: 1,
                      ),
                      MyListListViewVertical(
                        type: SearchType.anime,
                        animeMangaList: data.animeList,
                        indexTab: 2,
                      ),
                      MyListListViewVertical(
                        type: SearchType.anime,
                        animeMangaList: data.animeList,
                        indexTab: 3,
                      ),
                      MyListListViewVertical(
                        type: SearchType.anime,
                        animeMangaList: data.animeList,
                        indexTab: 4,
                      ),
                      MyListListViewVertical(
                        type: SearchType.anime,
                        animeMangaList: data.animeList,
                        indexTab: 5,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          if (state is MylistAnimeInitial) {
            log('MylistAnimeInitial');
            return const SizedBox.shrink();
          }

          /// Default
          log('default');

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
