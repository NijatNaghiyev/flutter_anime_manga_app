import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/data/models/info/themes_model.dart';
import 'package:flutter_anime_manga_app/view/screens/info/widgets/themes_view_element.dart';

import '../../../../data/models/info/music_videos_model.dart';

class ThemesList extends StatefulWidget {
  const ThemesList({super.key, this.themesModel, required this.musicVideos});

  final ThemesModel? themesModel;
  final List<MusicVideosModel> musicVideos;

  @override
  State<ThemesList> createState() => _ThemesListState();
}

class _ThemesListState extends State<ThemesList> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.themesModel != null)
            ThemesViewElement(
              title: 'Opening Themes',
              themesModel: widget.themesModel,
              musicVideos: widget.musicVideos,
            ),
          const SizedBox(height: 12),
          if (widget.themesModel != null)
            ThemesViewElement(
              title: 'Ending Themes',
              themesModel: widget.themesModel,
              musicVideos: widget.musicVideos,
            ),
        ],
      ),
    );
  }
}
