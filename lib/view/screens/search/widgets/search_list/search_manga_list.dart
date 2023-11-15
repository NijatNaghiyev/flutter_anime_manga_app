import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/state/bloc/search-screen/search/data_search_bloc.dart';
import '../../../../../features/state/cubit/search_lists/search_lists_cubit.dart';
import '../search_filter_row.dart';
import '../search_list_view_vertical/manga_search_list_view.dart';

class SearchMangaList extends StatelessWidget {
  const SearchMangaList({super.key, required this.state});

  final SearchLoadedMangaState state;
  @override
  Widget build(BuildContext context) {
    final stateData = state.mangaList.data ?? [];

    if (stateData.isNotEmpty) {
      context.read<SearchListsCubit>().mangaList.addAll(stateData);
    }

    return Column(
      children: [
        if (context.read<SearchListsCubit>().mangaList.isEmpty)
          const SearchFilterRow(),
        Expanded(
          child: MangaSearchListView(
            lastPage: state.mangaList.pagination!.lastVisiblePage ?? 0,
            stateData: context.read<SearchListsCubit>().mangaList,
          ),
        ),
      ],
    );
  }
}
