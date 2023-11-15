import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/features/state/bloc/search-screen/top_data/top_data_anime/top_data_anime_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/enum/search_type.dart';
import '../../../../../data/models/top_data/top_anime_model.dart';
import '../search_list_view_vertical/anime_card_vertical.dart';

class TopAnimeSeeAll extends StatefulWidget {
  const TopAnimeSeeAll({super.key, required this.stateData});

  final List<Datum> stateData;

  @override
  State<TopAnimeSeeAll> createState() => _TopAnimeSeeAllState();
}

class _TopAnimeSeeAllState extends State<TopAnimeSeeAll> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: const Text(
          'Top Anime',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.stateData.length,
          itemBuilder: (context, index) => AnimeCardVertical(
            isSearch: false,
            malId: widget.stateData[index].malId,
            searchType: SearchType.anime,
            index: index,
            imageUrl:
                widget.stateData[index].images['jpg']!.imageUrl.toString(),
            title: widget.stateData[index].title.toString(),
            type: widget.stateData[index].type?.name.toString() ?? '',
            episodes: widget.stateData[index].episodes,
            aired: widget.stateData[index].aired.string.split('to')[0],
            scoredBy: widget.stateData[index].scoredBy,
            scored: widget.stateData[index].score,
          ),
        ),
      ),
    );
  }
}

void paginationListenerTopSeeAll(
    {required BuildContext context,
    required SearchType searchType,
    required ScrollController controller}) {
  controller.addListener(
    () {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        context.read<TopDataAnimeBloc>().page++;
        context.read<TopDataAnimeBloc>().topAnimeDataList = [];
        context.read<TopDataAnimeBloc>().add(
              TopDataAnimeLoadEvent(),
            );
      }
    },
  );
}
