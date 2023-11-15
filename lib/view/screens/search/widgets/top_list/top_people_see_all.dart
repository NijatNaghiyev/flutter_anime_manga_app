import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';

import '../search_list_view_vertical/characters_card_vertical.dart';

class TopPeopleSeeAll extends StatefulWidget {
  const TopPeopleSeeAll({super.key, required this.stateData});

  final List stateData;

  @override
  State<TopPeopleSeeAll> createState() => _TopPeopleSeeAllState();
}

class _TopPeopleSeeAllState extends State<TopPeopleSeeAll> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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
          'Top People',
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
          itemBuilder: (context, index) => CharactersCardVertical(
            isSearch: false,
            index: index,
            imageUrl: widget.stateData[index].images.jpg.imageUrl.toString(),
            title: widget.stateData[index].name.toString(),
            favorites: widget.stateData[index].favorites,
          ),
        ),
      ),
    );
  }
}
