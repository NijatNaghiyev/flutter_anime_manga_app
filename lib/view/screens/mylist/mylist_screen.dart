import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/view/screens/mylist/widgets/anime_list_view.dart';
import 'package:flutter_anime_manga_app/view/screens/mylist/widgets/manga_list_view.dart';
import 'package:flutter_anime_manga_app/view/screens/mylist/widgets/mylist_app_bar_switch.dart';

import '../drawer/widgets/build_open_drawer.dart';

class MylistScreen extends StatefulWidget {
  const MylistScreen({super.key});

  @override
  State<MylistScreen> createState() => _MylistScreenState();
}

class _MylistScreenState extends State<MylistScreen> {
  final ValueNotifier<bool> _isSwitched = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buildOpenDrawer(context),
        backgroundColor: MyColors.primary,
        title: const Text(
          'Mylist',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          MylistAppBarSwitch(isSwitched: _isSwitched),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _isSwitched,
        builder: (context, value, _) {
          return IndexedStack(
            index: value ? 1 : 0,
            children: const [
              AnimeListView(),
              MangaListView(),
            ],
          );
        },
      ),
    );
  }
}
