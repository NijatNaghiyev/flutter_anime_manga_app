import 'package:flutter/material.dart';

import '../../../../constants/enum/search_type.dart';
import '../../../../constants/theme/colors.dart';

class InfoInitialArea extends StatelessWidget {
  const InfoInitialArea({
    super.key,
    required this.searchType,
    required this.time,
    required this.airing,
    required this.duration,
    required this.genres,
  });

  final String time;
  final String airing;
  final String duration;
  final List<String> genres;
  final SearchType searchType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          color: MyColors.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                airing,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                duration,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              for (var element in genres) ...[
                if (genres.indexOf(element) != 0)
                  const Text(
                    ' • ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: MyColors.primary,
                    ),
                  ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    element,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: MyColors.primary,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
