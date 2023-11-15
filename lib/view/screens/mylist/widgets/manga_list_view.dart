import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/enum/search_type.dart';
import '../../../../data/models/mylist/mylist_model.dart';
import '../../../../features/state/bloc/mylist_screen/manga_list/mylist_manga_bloc.dart';
import '../../../widgets/center_loading_indicator.dart';
import 'bottom_status.dart';
import 'mylist_list_view_vertical.dart';

class MangaListView extends StatefulWidget {
  const MangaListView({super.key});

  @override
  State<MangaListView> createState() => _MangaListViewState();
}

class _MangaListViewState extends State<MangaListView>
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
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MylistMangaBloc, MylistMangaState>(
        buildWhen: (previous, current) => current is! MylistMangaStateAction,
        listenWhen: (previous, current) => current is MylistMangaStateAction,
        listener: (context, state) {
          if (state is MylistMangaLoading) {
            log('MylistMangaLoading');

            isDialogOpen = true;
            showGeneralDialog(
              barrierDismissible: false,
              useRootNavigator: false,
              barrierColor: Colors.transparent,
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const CenterLoadingIndicator(),
            );
          }
        },
        builder: (context, state) {
          if (state is MylistMangaLoad) {
            log('MylistMangaLoad');

            closeDialog();

            final data = state as MylistMangaLoad;
            return Column(
              children: [
                BottomStatus(tabController: tabController),
                Expanded(
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    controller: tabController,
                    children: [
                      MyListListViewVertical(
                        type: SearchType.manga,
                        animeMangaList: data.mangaList,
                        indexTab: 0,
                      ),
                      MyListListViewVertical(
                        type: SearchType.manga,
                        animeMangaList: data.mangaList,
                        indexTab: 1,
                      ),
                      MyListListViewVertical(
                        type: SearchType.manga,
                        animeMangaList: data.mangaList,
                        indexTab: 2,
                      ),
                      MyListListViewVertical(
                        type: SearchType.manga,
                        animeMangaList: data.mangaList,
                        indexTab: 3,
                      ),
                      MyListListViewVertical(
                        type: SearchType.manga,
                        animeMangaList: data.mangaList,
                        indexTab: 4,
                      ),
                      MyListListViewVertical(
                        type: SearchType.manga,
                        animeMangaList: data.mangaList,
                        indexTab: 5,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          if (state is MylistMangaInitial) {
            log('MylistMangaInitial');
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
