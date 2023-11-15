import 'package:flutter/material.dart';

import '../../../../../constants/enum/search_type.dart';
import '../../../../../data/models/manga/manga_search_model.dart';
import 'anime_card_vertical.dart';
import 'anime_search_list_view.dart';

class MangaSearchListView extends StatefulWidget {
  const MangaSearchListView(
      {super.key, required this.stateData, required this.lastPage});

  final List<MangaDatum> stateData;
  final int lastPage;

  @override
  State<MangaSearchListView> createState() => _MangaSearchListViewState();
}

class _MangaSearchListViewState extends State<MangaSearchListView> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    paginationListenerSearch(
      context: context,
      lastPage: widget.lastPage,
      searchType: SearchType.manga,
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
          searchType: SearchType.manga,
          index: index,
          imageUrl: widget.stateData[index].images!['jpg']!.imageUrl.toString(),
          title: widget.stateData[index].title.toString(),
          type: widget.stateData[index].type.toString(),
          episodes: widget.stateData[index].chapters,
          aired: widget.stateData[index].published?.string?.split('to')[0] ??
              widget.stateData[index].published?.from?.year.toString(),
          scoredBy: widget.stateData[index].scoredBy,
          scored: widget.stateData[index].score,
        ),
      ),
    );
  }
}
