import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/view/screens/info/widgets/score_rank_column.dart';

import 'info_carousel.dart';

class ImageRow extends StatelessWidget {
  const ImageRow({
    super.key,
    required this.imagesList,
    required this.data,
  });

  final data;
  final List<String> imagesList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          InfoCarousel(imagesList: imagesList),
          const Spacer(),
          ScoreRankColumn(data: data),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
