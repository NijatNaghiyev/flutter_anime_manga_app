import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';

import '../../../data/models/info/music_videos_model.dart';
import '../../../data/models/info/themes_model.dart';

class ThemesViewElement extends StatelessWidget {
  const ThemesViewElement({
    super.key,
    required this.title,
    this.themesModel,
    required this.musicVideos,
  });

  final String title;
  final ThemesModel? themesModel;
  final List<MusicVideosModel> musicVideos;

  @override
  Widget build(BuildContext context) {
    final data = title == 'Opening Themes'
        ? themesModel?.openings
        : themesModel?.endings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data?.length ?? 0,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Wrap(
                children: [
                  RichText(
                    text: TextSpan(children: [
                      if (data!.length == 1) ...[
                        TextSpan(
                          text: data[index].split('by')[0].toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: MyColors.primaryLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      if (data.length > 1) ...[
                        TextSpan(
                          text: data[index]
                              .split('by')[0]
                              .substring(0, 3)
                              .toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: data[index]
                              .split('by')[0]
                              .substring(3)
                              .toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: MyColors.primaryLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      TextSpan(
                        text: ' by${data[index].split('by')[1]}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
