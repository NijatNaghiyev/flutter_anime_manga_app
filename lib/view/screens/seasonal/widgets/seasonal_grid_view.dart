import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/enum/parameter_search_type.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/view/screens/seasonal/pages/season_archive_page.dart';
import 'package:flutter_anime_manga_app/view/screens/seasonal/widgets/grid_view_filter_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/mylist/mylist_model.dart';
import '../../../../data/models/seasonal/seasonal_model.dart';
import '../../../../features/state/bloc/seasonal/season_archive/season_archive_bloc.dart';
import '../../../../features/state/bloc/seasonal/season_last/season_last_bloc.dart';
import '../../../../features/state/bloc/seasonal/season_now/season_now_bloc.dart';
import '../../../../features/state/bloc/seasonal/season_upcoming/season_upcoming_bloc.dart';
import 'seasonal_grid_view_card.dart';

ValueNotifier<ParameterSearchTypeAnime> searchType =
    ValueNotifier(ParameterSearchTypeAnime.Default);

class SeasonalGridView extends StatefulWidget {
  const SeasonalGridView({
    super.key,
    required this.data,
    required this.blocType,
    required this.animeList,
  });

  final String blocType;
  final List<SeasonalData> data;
  final List<MylistModel> animeList;

  @override
  State<SeasonalGridView> createState() => _SeasonalGridViewState();
}

class _SeasonalGridViewState extends State<SeasonalGridView>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  /// Pagination listener Seasonal
  void paginationListenerSeasonal(
      {required BuildContext context,
      required ParameterSearchTypeAnime searchType,
      required ScrollController controller}) {
    controller.addListener(
      () {
        if (controller.position.pixels == controller.position.maxScrollExtent) {
          if (widget.blocType == 'season_now') {
            context.read<SeasonNowBloc>().add(
                  SeasonNowInitialEvent(
                    type: searchType,
                  ),
                );
          } else if (widget.blocType == 'season_last') {
            context.read<SeasonLastBloc>().add(
                  SeasonLastInitialEvent(
                    type: searchType,
                  ),
                );
          } else if (widget.blocType == 'season_upcoming') {
            context.read<SeasonUpcomingBloc>().add(
                  SeasonUpcomingInitialEvent(
                    type: searchType,
                  ),
                );
          } else if (widget.blocType == 'season_archive') {
            context.read<SeasonArchiveBloc>().add(
                  SeasonArchiveInitialEvent(
                    type: searchType,
                    year: yearArchive.value!,
                    season: seasonArchive.value!,
                  ),
                );
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    paginationListenerSeasonal(
      context: context,
      searchType: searchType.value,
      controller: _scrollController,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      color: MyColors.primary,
      onRefresh: () async {
        if (widget.blocType == 'season_now') {
          context.read<SeasonNowBloc>().page = 1;
          context.read<SeasonNowBloc>().seasonalData = [];

          context.read<SeasonNowBloc>().add(
                SeasonNowInitialEvent(
                  type: searchType.value,
                ),
              );
        } else if (widget.blocType == 'season_last') {
          context.read<SeasonLastBloc>().page = 1;
          context.read<SeasonLastBloc>().seasonalData = [];

          context.read<SeasonLastBloc>().add(
                SeasonLastInitialEvent(
                  type: searchType.value,
                ),
              );
        } else if (widget.blocType == 'season_upcoming') {
          context.read<SeasonUpcomingBloc>().page = 1;
          context.read<SeasonUpcomingBloc>().seasonalData = [];

          context.read<SeasonUpcomingBloc>().add(
                SeasonUpcomingInitialEvent(
                  type: searchType.value,
                ),
              );
        } else if (widget.blocType == 'season_archive') {
          context.read<SeasonUpcomingBloc>().page = 1;
          context.read<SeasonUpcomingBloc>().seasonalData = [];

          context.read<SeasonArchiveBloc>().add(
                SeasonArchiveInitialEvent(
                  type: searchType.value,
                  year: yearArchive.value!,
                  season: seasonArchive.value!,
                ),
              );
        }
      },
      child: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              if (widget.blocType == 'season_archive')
                Row(
                  children: [
                    BackButton(
                      onPressed: () {
                        context
                            .read<SeasonArchiveBloc>()
                            .add(const SeasonArchiveInitPageEvent());
                      },
                    )
                  ],
                ),
              GridViewFilterRow(data: widget.data),
              GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: widget.data.length,
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (context, index) {
                  return SeasonalGridViewCard(
                    data: widget.data[index],
                    animeList: widget.animeList,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
