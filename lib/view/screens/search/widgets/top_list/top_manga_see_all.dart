import 'package:flutter/material.dart';

import '../../../../../constants/enum/search_type.dart';
import '../../../../../constants/theme/colors.dart';
import '../search_list_view_vertical/anime_card_vertical.dart';

class TopMangaSeeAll extends StatefulWidget {
  const TopMangaSeeAll({super.key, required this.stateData});

  final List stateData;

  @override
  State<TopMangaSeeAll> createState() => _TopMangaSeeAllState();
}

class _TopMangaSeeAllState extends State<TopMangaSeeAll> {
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
          'Top Manga',
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
            malId: widget.stateData[index].malId!,
            searchType: SearchType.manga,
            index: index,
            imageUrl:
                widget.stateData[index].images!['jpg']!.imageUrl.toString(),
            title: widget.stateData[index].title.toString(),
            type: widget.stateData[index].type
                    ?.toString()
                    .split('.')[1]
                    .substring(0, 5)
                    .toString() ??
                '',
            episodes: widget.stateData[index].chapters,
            aired: widget.stateData[index].published?.string?.split('to')[0] ??
                widget.stateData[index].published?.from?.year.toString(),
            scoredBy: widget.stateData[index].scoredBy,
            scored: widget.stateData[index].score,
          ),
        ),
      ),
    );
  }
}
