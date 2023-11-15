import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/enum/search_type.dart';
import '../../../../../data/models/anime/anime_search_model.dart';
import '../../../../../features/state/bloc/search-screen/search/data_search_bloc.dart';
import 'anime_card_vertical.dart';

class AnimeSearchListView extends StatefulWidget {
  const AnimeSearchListView(
      {super.key, required this.stateData, required this.lastPage});

  final List<Datum> stateData;
  final int lastPage;

  @override
  State<AnimeSearchListView> createState() => _AnimeSearchListViewState();
}

class _AnimeSearchListViewState extends State<AnimeSearchListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    paginationListenerSearch(
      context: context,
      lastPage: widget.lastPage,
      searchType: SearchType.anime,
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
    return Scrollbar(
      controller: _scrollController,
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.stateData.length,
        itemBuilder: (context, index) => AnimeCardVertical(
          malId: widget.stateData[index].malId!,
          searchType: SearchType.anime,
          index: index,
          imageUrl: widget.stateData[index].images!['jpg']!.imageUrl.toString(),
          title: widget.stateData[index].title.toString(),
          type: widget.stateData[index].type.toString(),
          episodes: widget.stateData[index].episodes,
          aired: widget.stateData[index].aired?.string?.split('to')[0] ??
              widget.stateData[index].aired?.from?.year.toString(),
          scoredBy: widget.stateData[index].scoredBy,
          scored: widget.stateData[index].score,
        ),
      ),
    );
  }
}

void paginationListenerSearch(
    {required BuildContext context,
    required int lastPage,
    required SearchType searchType,
    required ScrollController controller}) {
  controller.addListener(
    () {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (context.read<SearchBloc>().page < lastPage) {
          context.read<SearchBloc>().page++;
          context.read<SearchBloc>().add(
                DataSearchSearchEvent(
                  searchType: searchType,
                  query: context.read<SearchBloc>().queryBloc,
                ),
              );
        }
      }
    },
  );
}
