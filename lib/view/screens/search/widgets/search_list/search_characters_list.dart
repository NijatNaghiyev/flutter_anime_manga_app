import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/state/bloc/search-screen/search/data_search_bloc.dart';
import '../../../../../features/state/cubit/search_lists/search_lists_cubit.dart';
import '../search_filter_row.dart';
import '../search_list_view_vertical/characters_search_list_view.dart';

class SearchCharactersList extends StatelessWidget {
  const SearchCharactersList({super.key, required this.state});

  final SearchLoadedCharactersState state;
  @override
  Widget build(BuildContext context) {
    final stateData = state.charactersList.data;

    if (stateData.isNotEmpty) {
      context.read<SearchListsCubit>().charactersList.addAll(stateData);
    }

    return Column(
      children: [
        if (context.read<SearchListsCubit>().charactersList.isEmpty)
          const SearchFilterRow(),
        Expanded(
          child: CharactersSearchListView(
            lastPage: state.charactersList.pagination!.lastVisiblePage,
            stateData: context.read<SearchListsCubit>().charactersList,
          ),
        ),
      ],
    );
  }
}
