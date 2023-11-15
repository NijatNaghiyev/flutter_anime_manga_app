import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../features/router/routers.dart';
import '../../../../../features/state/bloc/search-screen/top_data/top_characters/top_characters_bloc.dart';
import '../../../../widgets/shimmer_list_view_horizontal.dart';
import '../custom_row_title.dart';
import '../list_view_horizontal_people.dart';
import '../search_initial.dart';

class TopCharactersList extends StatelessWidget {
  const TopCharactersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: BlocBuilder<TopCharactersBloc, TopCharactersState>(
        builder: (context, state) {
          /// Loaded
          if (state is TopCharactersLoadState) {
            final topCharactersData = state.topCharactersModel.data as List;
            return Column(
              children: [
                CustomRowTitle(
                  title: 'Top Characters',
                  onTap: () {
                    context.pushNamed(
                      MyRouters.charactersSeeAll.name,
                      extra: topCharactersData,
                    );
                  },
                ),
                ListViewHorizontalPeople(topPeopleData: topCharactersData),
              ],
            );
          }

          /// Loading State
          if (state is TopCharactersInitial) {
            return const ShimmerListViewHorizontal();
          }

          /// Error State
          if (state is TopCharactersErrorState) {
            return ErrorRetry(
              state: state,
              onRetry: () {
                context
                    .read<TopCharactersBloc>()
                    .add(const TopCharactersLoadEvent());
              },
            );
          }

          /// Default
          return const Text('');
        },
      ),
    );
  }
}
