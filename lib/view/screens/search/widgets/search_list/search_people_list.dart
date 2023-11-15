import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/state/bloc/search-screen/search/data_search_bloc.dart';
import '../../../../../features/state/cubit/search_lists/search_lists_cubit.dart';
import '../search_filter_row.dart';
import '../search_list_view_vertical/people_search_list_view.dart';

class SearchPeopleList extends StatelessWidget {
  const SearchPeopleList({super.key, required this.state});

  final SearchLoadedPeopleState state;
  @override
  Widget build(BuildContext context) {
    final stateData = state.peopleList.data;

    if (stateData.isNotEmpty) {
      context.read<SearchListsCubit>().peopleList.addAll(stateData);
    }

    return Column(
      children: [
        if (context.read<SearchListsCubit>().peopleList.isEmpty)
          const SearchFilterRow(),
        Expanded(
          child: PeopleSearchListView(
            lastPage: state.peopleList.pagination.lastVisiblePage,
            stateData: context.read<SearchListsCubit>().peopleList,
          ),
        ),
      ],
    );
  }
}
