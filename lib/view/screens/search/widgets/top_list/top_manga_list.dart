import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/enum/search_type.dart';
import '../../../../../features/router/routers.dart';
import '../../../../../features/state/bloc/search-screen/top_data/top_manga/top_manga_bloc.dart';
import '../../../../widgets/shimmer_list_view_horizontal.dart';
import '../custom_row_title.dart';
import '../list_view_horizontal.dart';
import '../search_initial.dart';

class TopMangaList extends StatelessWidget {
  const TopMangaList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: BlocBuilder<TopMangaBloc, TopMangaState>(
        builder: (context, state) {
          /// Loaded
          if (state is TopMangaLoadState) {
            final topMangaData = state.topMangaModel.data as List;
            return Column(
              children: [
                CustomRowTitle(
                  title: 'Top Manga',
                  onTap: () {
                    context.pushNamed(
                      MyRouters.mangaSeeAll.name,
                      extra: topMangaData,
                    );
                  },
                ),
                ListViewHorizontal(
                  topData: topMangaData,
                  type: SearchType.manga,
                ),
              ],
            );
          }

          /// Loading State
          if (state is TopMangaInitial) {
            return const ShimmerListViewHorizontal();
          }

          /// Error State
          if (state is TopMangaErrorState) {
            return ErrorRetry(
              state: state,
              onRetry: () {
                context.read<TopMangaBloc>().add(
                      const TopMangaLoadEvent(),
                    );
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
