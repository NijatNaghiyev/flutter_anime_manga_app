import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/enum/search_type.dart';
import 'package:flutter_anime_manga_app/data/models/manga/manga_full_model.dart';
import 'package:flutter_anime_manga_app/view/info/widgets/info_adaptation.dart';
import 'package:flutter_anime_manga_app/view/info/widgets/info_characters.dart';
import 'package:flutter_anime_manga_app/view/info/widgets/info_news_list.dart';
import 'package:flutter_anime_manga_app/view/info/widgets/read_more_synopsis.dart';
import 'package:flutter_anime_manga_app/view/info/widgets/recommendations_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constants/theme/colors.dart';
import '../../../features/state/bloc/info/info_bloc/info_bloc.dart';
import 'favorite_icon_value_listenable.dart';
import 'image_row.dart';
import 'info_below_image_manga.dart';
import 'info_initial_area.dart';
import 'info_statistics_manga_list.dart';
import 'info_title.dart';

class InfoMangaLoadedPage extends StatefulWidget {
  const InfoMangaLoadedPage(
      {super.key, required this.mangaFullModel, required this.imagesList});

  final MangaFullModel mangaFullModel;
  final List<String> imagesList;

  @override
  State<InfoMangaLoadedPage> createState() => _InfoMangaLoadedPageState();
}

class _InfoMangaLoadedPageState extends State<InfoMangaLoadedPage> {
  @override
  Widget build(BuildContext context) {
    final data = widget.mangaFullModel.data!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: MyColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        leading: const BackButton(),
        actions: [
          /// Favorite icon
          FavoriteIconValueListenable(data: data, searchType: SearchType.manga),

          /// Share icon
          IconButton(
            onPressed: () async {
              await Share.shareUri(Uri.parse(data.url ?? 'No url'));
            },
            icon: const Icon(Icons.ios_share),
          ),
        ],
        title: const Text(
          'FAM',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: MyColors.primary,
        onRefresh: () async {
          context.read<InfoBloc>().add(
                InfoMangaEvent(malId: data.malId!),
              );
        },
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 70),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// Image
                ImageRow(imagesList: widget.imagesList, data: data),

                /// Title
                InfoTitle(title: data.titles?[0].title! ?? 'N/A'),

                /// Initial area
                InfoInitialArea(
                  time:
                      '${data.type ?? 'N/A'}, ${data.published?.prop?.from?.year ?? 'N/A'}',
                  airing: data.status ?? 'N/A',
                  duration:
                      '${data.chapters ?? '??'} chp, ${data.volumes ?? '??'} vol',
                  genres: data.genres?.map((e) => e.name!).toList() ?? [],
                  searchType: SearchType.anime,
                ),

                /// Synopsis
                ReadMoreSynopsis(text: data.synopsis ?? ''),

                /// InfoBelowImage
                InfoBelowImageManga(data: data),

                /// Adaptation
                InfoAdaptation(data: data, searchType: SearchType.manga),

                /// Characters
                InfoCharacters(
                  malId: data.malId!,
                  searchType: SearchType.manga,
                ),

                /// Recommendations
                RecommendationsList(
                    searchType: SearchType.manga, malId: data.malId!),

                /// News
                InfoNewsList(
                  searchType: SearchType.manga,
                  malId: data.malId!,
                ),

                /// InfoStatisticsMangaList
                InfoStatisticsMangaList(
                  malId: data.malId!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
