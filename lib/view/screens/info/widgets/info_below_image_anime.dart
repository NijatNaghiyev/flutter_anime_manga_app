import 'package:flutter/material.dart';

import '../../../../data/models/anime/anime_full_model.dart';
import 'info_below_image_element.dart';

class InfoBelowImageAnime extends StatelessWidget {
  const InfoBelowImageAnime({super.key, required this.data});

  final Data data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InfoBelowImageElement(
              title: 'English', data: data.titleEnglish ?? 'N/A'),
          const SizedBox(height: 8),
          Wrap(
            children: [
              InfoBelowImageElement(
                title: 'Source',
                data: data.source ?? 'N/A',
              ),
              const SizedBox(width: 40),
              InfoBelowImageElement(
                title: 'Season',
                data: data.season ?? 'N/A',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            children: [
              InfoBelowImageElement(
                title: 'Studio',
                data: data.studios?[0].name ?? 'N/A',
              ),
              const SizedBox(width: 40),
              InfoBelowImageElement(
                title: 'Aired',
                data: data.aired?.string ?? 'N/A',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            children: [
              InfoBelowImageElement(
                title: 'Rating',
                data: data.rating?.split('-')[0] ?? 'N/A',
              ),
              const SizedBox(width: 40),
              InfoBelowImageElement(
                title: 'Licensor',
                data:
                    '${data.licensors!.isEmpty ? 'N/A' : data.licensors?.first['name'] ?? 'N/A'}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
