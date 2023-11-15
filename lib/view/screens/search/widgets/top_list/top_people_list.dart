import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../features/router/routers.dart';
import '../../../../../features/state/bloc/search-screen/top_data/top_people/top_people_bloc.dart';
import '../../../../widgets/shimmer_list_view_horizontal.dart';
import '../custom_row_title.dart';
import '../list_view_horizontal_people.dart';
import '../search_initial.dart';

class TopPeopleList extends StatelessWidget {
  const TopPeopleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: BlocBuilder<TopPeopleBloc, TopPeopleState>(
        builder: (context, state) {
          /// Loaded
          if (state is TopPeopleLoadState) {
            final topPeopleData = state.topPeopleModel.data as List;
            return Column(
              children: [
                CustomRowTitle(
                  title: 'Top People',
                  onTap: () {
                    context.pushNamed(
                      MyRouters.peopleSeeAll.name,
                      extra: topPeopleData,
                    );
                  },
                ),
                ListViewHorizontalPeople(topPeopleData: topPeopleData),
              ],
            );
          }

          /// Loading State
          if (state is TopPeopleInitial) {
            return const ShimmerListViewHorizontal();
          }

          /// Error State
          if (state is TopPeopleErrorState) {
            return ErrorRetry(
              state: state,
              onRetry: () {
                context.read<TopPeopleBloc>().add(const TopPeopleLoadEvent());
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
