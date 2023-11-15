import 'package:flutter/material.dart';

import '../../../../../constants/enum/search_type.dart';
import '../../../../../data/models/people/people_search_model.dart';
import 'anime_search_list_view.dart';
import 'characters_card_vertical.dart';

class PeopleSearchListView extends StatefulWidget {
  const PeopleSearchListView(
      {super.key, required this.stateData, required this.lastPage});

  final List<PeopleDatum> stateData;
  final int lastPage;

  @override
  State<PeopleSearchListView> createState() => _PeopleSearchListViewState();
}

class _PeopleSearchListViewState extends State<PeopleSearchListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    paginationListenerSearch(
      context: context,
      lastPage: widget.lastPage,
      searchType: SearchType.people,
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
        itemBuilder: (context, index) => CharactersCardVertical(
          index: index,
          imageUrl: widget.stateData[index].images.jpg.imageUrl.toString(),
          title: widget.stateData[index].name.toString(),
          favorites: widget.stateData[index].favorites,
        ),
      ),
    );
  }
}
