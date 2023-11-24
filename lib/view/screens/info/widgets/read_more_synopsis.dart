import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../constants/theme/colors.dart';

class ReadMoreSynopsis extends StatelessWidget {
  const ReadMoreSynopsis({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ReadMoreText(
          text,
          trimLines: 4,
          trimMode: TrimMode.Line,
          textAlign: TextAlign.start,
          trimCollapsedText: 'Show more',
          trimExpandedText: '  Show less',
          lessStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: MyColors.primary,
          ),
          moreStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: MyColors.primary,
          ),
        ),
      ),
    );
  }
}
