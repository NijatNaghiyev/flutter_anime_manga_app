import 'package:flutter/material.dart';

import '../../../../data/models/manga/manga_full_model.dart';
import 'info_below_image_element.dart';

class InfoBelowImageManga extends StatelessWidget {
  const InfoBelowImageManga({super.key, required this.data});

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
            runSpacing: 8,
            children: [
              InfoBelowImageElement(
                title: 'Published',
                data: data.published?.string ?? 'N/A',
              ),
              const SizedBox(width: 40),
              InfoBelowImageElement(
                title: 'Authors',
                data: data.authors
                        ?.map((e) =>
                            '${e.name ?? 'N/A'} (${e.type?.name ?? 'N/A'})')
                        .toList()
                        .join(', ') ??
                    'N/A',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            runSpacing: 8,
            children: [
              InfoBelowImageElement(
                title: 'Serialization',
                data: data.serializations!.isEmpty
                    ? 'N/A'
                    : data.serializations?.first.name ?? 'N/A',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
