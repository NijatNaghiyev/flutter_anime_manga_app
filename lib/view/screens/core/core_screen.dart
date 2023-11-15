import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../features/state/bloc/search-screen/search/data_search_bloc.dart';
import '../../../features/state/cubit/core/bottom_nav_bar_cubit.dart';

class CoreScreen extends StatefulWidget {
  const CoreScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {
  void _goBranch(int index) {
    if (index == 1 && widget.navigationShell.currentIndex == 1) {
      context.read<SearchBloc>().add(
            SearchInitialEvent(),
          );
    }
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BlocBuilder<BottomNavBarCubit, bool>(
        builder: (context, state) {
          return AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState:
                state ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            secondChild: const SizedBox.shrink(),
            firstChild: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SalomonBottomBar(
                margin: const EdgeInsets.all(10),
                backgroundColor: MyColors.primary,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.white,
                currentIndex: widget.navigationShell.currentIndex,
                onTap: _goBranch,
                items: [
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.home_filled),
                    title: const Text('Home'),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.search),
                    title: const Text('Search'),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.calendar_month),
                    title: const Text('Seasonal'),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.view_list),
                    title: const Text('My list'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
