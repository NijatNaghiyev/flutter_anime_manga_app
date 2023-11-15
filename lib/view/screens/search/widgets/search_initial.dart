import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/top_list/top_anime_list.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/top_list/top_characters_list.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/top_list/top_manga_list.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/top_list/top_people_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme/colors.dart';
import '../../../../features/state/bloc/search-screen/top_data/top_characters/top_characters_bloc.dart';
import '../../../../features/state/bloc/search-screen/top_data/top_data_anime/top_data_anime_bloc.dart';
import '../../../../features/state/bloc/search-screen/top_data/top_manga/top_manga_bloc.dart';
import '../../../../features/state/bloc/search-screen/top_data/top_people/top_people_bloc.dart';

class SearchInitialView extends StatefulWidget {
  const SearchInitialView({super.key});

  @override
  State<SearchInitialView> createState() => _SearchInitialViewState();
}

class _SearchInitialViewState extends State<SearchInitialView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: MyColors.primary,
      onRefresh: () async {
        context.read<TopDataAnimeBloc>().add(
              const TopDataAnimeLoadEvent(),
            );
        context.read<TopMangaBloc>().add(
              const TopMangaLoadEvent(),
            );

        await Future.delayed(const Duration(milliseconds: 1500));

        context.read<TopPeopleBloc>().add(
              const TopPeopleLoadEvent(),
            );
        context.read<TopCharactersBloc>().add(
              const TopCharactersLoadEvent(),
            );
      },
      child: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          child: const Column(
            children: [
              TopAnimeList(),
              SizedBox(height: 4.0),
              TopMangaList(),
              SizedBox(height: 4.0),
              TopPeopleList(),
              SizedBox(height: 4.0),
              TopCharactersList(),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorRetry extends StatelessWidget {
  const ErrorRetry({
    super.key,
    required this.state,
    required this.onRetry,
  });
  final state;
  final void Function() onRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.message),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
