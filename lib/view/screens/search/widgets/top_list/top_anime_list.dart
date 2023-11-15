import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/enum/search_type.dart';
import '../../../../../features/router/routers.dart';
import '../../../../../features/state/bloc/search-screen/top_data/top_data_anime/top_data_anime_bloc.dart';
import '../../../../widgets/shimmer_list_view_horizontal.dart';
import '../custom_row_title.dart';
import '../list_view_horizontal.dart';
import '../search_initial.dart';

class TopAnimeList extends StatelessWidget {
  const TopAnimeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: BlocBuilder<TopDataAnimeBloc, TopDataAnimeState>(
        builder: (context, state) {
          /// Loaded
          if (state is TopDataAnimeLoadState) {
            final topAnimeData = state.topAnimeModel as List;
            return Column(
              children: [
                CustomRowTitle(
                  title: 'Top Anime',
                  onTap: () {
                    context.pushNamed(
                      MyRouters.animeSeeAll.name,
                      extra: topAnimeData,
                    );
                  },
                ),
                ListViewHorizontal(
                  topData: topAnimeData,
                  type: SearchType.anime,
                ),
              ],
            );
          }

          /// Loading State
          if (state is TopDataAnimeInitial) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: ShimmerListViewHorizontal(),
            );
          }

          /// Error State
          if (state is TopDataAnimeErrorState) {
            return ErrorRetry(
              state: state,
              onRetry: () {
                context
                    .read<TopDataAnimeBloc>()
                    .add(const TopDataAnimeLoadEvent());
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
