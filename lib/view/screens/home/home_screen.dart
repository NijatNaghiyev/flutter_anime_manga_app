import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/enum/search_type.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/services/info/character.dart';
import '../../../features/state/bloc/mylist_screen/anime_list/mylist_anime_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: MyColors.primary,
              ),
            ),
            title: const Text('Home'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Color customColor = Colors.red;
                          showGeneralDialog(
                            barrierDismissible: false,
                            useRootNavigator: false,
                            barrierColor: Colors.transparent,
                            context: context,
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Center(
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return Container(
                                    height: 100,
                                    width: 100,
                                    color: customColor,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {});
                                        customColor = Colors.blue;
                                      },
                                      child: const Text('change color'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: const Text('Dialog'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<MylistAnimeBloc>().add(
                                const MylistAnimeLoadEvent(),
                              );
                        },
                        child: const Text('Toast'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/test');
                        },
                        child: const Text('Test'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
