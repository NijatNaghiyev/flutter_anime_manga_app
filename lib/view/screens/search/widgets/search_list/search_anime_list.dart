import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/state/bloc/search-screen/search/data_search_bloc.dart';
import '../../../../../features/state/cubit/search_lists/search_lists_cubit.dart';
import '../search_filter_row.dart';
import '../search_list_view_vertical/anime_search_list_view.dart';

class SearchAnimeList extends StatelessWidget {
  const SearchAnimeList({
    super.key,
    required this.state,
  });

  final SearchLoadedAnimeState state;

  @override
  Widget build(BuildContext context) {
    final stateData = state.animeList.data ?? [];

    if (stateData.isNotEmpty) {
      context.read<SearchListsCubit>().animeList.addAll(stateData);
    }
    return Column(
      children: [
        if (context.read<SearchListsCubit>().animeList.isEmpty)
          const SearchFilterRow(),
        Expanded(
          child: AnimeSearchListView(
            lastPage: state.animeList.pagination?.lastVisiblePage ?? 0,
            stateData: context.read<SearchListsCubit>().animeList,
          ),
        ),
      ],
    );
  }
}
