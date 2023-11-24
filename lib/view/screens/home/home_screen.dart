import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/data/models/anime/recent_reviews_anime_model.dart';
import 'package:flutter_anime_manga_app/features/state/bloc/home/home_screen/home_bloc.dart';
import 'package:flutter_anime_manga_app/features/state/cubit/core/bottom_nav_bar_cubit.dart';
import 'package:flutter_anime_manga_app/view/screens/home/widgets/home_news_list_element.dart';
import 'package:flutter_anime_manga_app/view/screens/home/widgets/recent_reviews_list_element.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/manga/recent_reviews_manga_model.dart';
import '../../widgets/shimmer_list_view_vertical.dart';
import '../drawer/widgets/build_open_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();

  void fadeBottomNavBar() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        context.read<BottomNavBarCubit>().changeState(false);
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        context.read<BottomNavBarCubit>().changeState(true);
      }
    });
  }

  @override
  void initState() {
    fadeBottomNavBar();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              primary: true,
              pinned: false,
              expandedHeight: 50.0,
              stretch: true,
              forceElevated: innerBoxIsScrolled,
              leading: buildOpenDrawer(context),
              backgroundColor: MyColors.primary,
              title: const Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          color: MyColors.primary,
          onRefresh: () async {
            context.read<HomeBloc>().add(HomeEventInitial());
          },
          child: Scrollbar(
            controller: scrollController,
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is HomeLoadedState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.allList.length,
                    itemBuilder: (context, index) {
                      final data = state.allList[index];
                      if (data is RecentReviewsAnimeModel ||
                          data is RecentReviewsMangaModel) {
                        return RecentReviewsListElement(
                          data: data,
                        );
                      } else {
                        return HomeNewsListElement(
                          data: data,
                        );
                      }
                    },
                  );
                }

                if (state is HomeLoadingState) {
                  return const ShimmerListViewVertical();
                }

                /// Default
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),

      /// FAB
      floatingActionButton: BlocBuilder<BottomNavBarCubit, bool>(
        builder: (context, state) {
          return AnimatedCrossFade(
            reverseDuration: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 300),
            crossFadeState:
                !state ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            secondChild: const SizedBox.shrink(),
            firstChild: FloatingActionButton(
              elevation: 0,
              shape: const CircleBorder(),
              onPressed: () async {
                await scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );

                context.read<BottomNavBarCubit>().changeState(true);
              },
              child: const Icon(
                Icons.arrow_upward_outlined,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
