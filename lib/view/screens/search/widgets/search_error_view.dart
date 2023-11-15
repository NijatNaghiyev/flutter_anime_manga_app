import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme/colors.dart';
import '../../../../features/state/bloc/search-screen/search/data_search_bloc.dart';
import 'custom_app_bar_bottom.dart';

class SearchErrorView extends StatelessWidget {
  const SearchErrorView({super.key, required this.state});

  final SearchErrorState state;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message.toString(),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primary,
            ),
            onPressed: () {
              context.read<SearchBloc>().add(
                    DataSearchSearchEvent(
                      searchType: searchTypeValueNotifier.value,
                      query: context.read<SearchBloc>().queryBloc,
                    ),
                  );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
