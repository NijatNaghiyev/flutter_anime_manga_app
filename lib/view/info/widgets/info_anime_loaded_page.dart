import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/enum/search_type.dart';
import 'package:flutter_anime_manga_app/data/models/info/themes_model.dart';
import 'package:flutter_anime_manga_app/data/models/mylist/mylist_model.dart';
import 'package:flutter_anime_manga_app/view/info/widgets/info_anime_staff.dart';
import 'package:flutter_anime_manga_app/view/info/widgets/read_more_synopsis.dart';
import 'package:flutter_anime_manga_app/view/info/widgets/recommendations_list.dart';
import 'package:flutter_anime_manga_app/view/info/widgets/themes_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constants/theme/colors.dart';
import '../../../data/models/anime/anime_full_model.dart';
import '../../../data/models/info/anime_staff_model.dart';
import '../../../data/models/info/favorite_model.dart';
import '../../../data/models/info/music_videos_model.dart';
import '../../../data/models/info/review_model.dart';
import '../../../data/services/firestore_database/favorite_anime_firebase.dart';
import '../../../features/state/bloc/info/info_bloc/info_bloc.dart';
import '../../widgets/edit_list_bottom_sheet.dart';
import 'favorite_icon_value_listenable.dart';
import 'image_row.dart';
import 'info_adaptation.dart';
import 'info_below_image_anime.dart';
import 'info_characters.dart';
import 'info_initial_area.dart';
import 'info_news_list.dart';
import 'info_statistics_anime_list.dart';
import 'info_title.dart';
import 'info_youtube_video.dart';

class InfoAnimeLoadedPage extends StatefulWidget {
  const InfoAnimeLoadedPage({
    super.key,
    required this.animeFullModel,
    required this.imagesList,
    required this.animeStaff,
    this.themesModel,
    required this.musicVideos,
    required this.reviews,
  });

  final AnimeFullModel animeFullModel;
  final List<String> imagesList;
  final List<AnimeStaffModel> animeStaff;
  final ThemesModel? themesModel;
  final List<MusicVideosModel> musicVideos;
  final List<ReviewModel> reviews;

  @override
  State<InfoAnimeLoadedPage> createState() => _InfoAnimeLoadedPageState();
}

class _InfoAnimeLoadedPageState extends State<InfoAnimeLoadedPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    FavoriteAnimeFirebaseService.getFavoriteAnimeList().then((value) =>
        favoriteAnimeMangaListValueNotifier.value['anime'] =
            value.cast<FavoriteModel>());
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.animeFullModel.data!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEditListBottomSheet(
            context: context,
            type: SearchType.anime,
            mylistModel: MylistModel(
              malId: data.malId!,
              animeOrManga: SearchType.anime.name,
              imageUrl: data.images!['jpg']!.imageUrl!,
              title: data.title!,
              type: data.type!,
              userStatus: null,
              airingStart: data.aired!.string!,
              episodesOrChapters: data.episodes,
              userProgress: null,
              userScore: null,
              userStartDate: null,
              userEndDate: null,
              addedTime: null,
            ),
          );
        },
        backgroundColor: MyColors.primary,
        child: const Icon(
          Icons.edit_note,
          color: Colors.white,
          size: 32,
        ),
      ),
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        leading: const BackButton(),
        actions: [
          /// Favorite icon
          FavoriteIconValueListenable(data: data, searchType: SearchType.anime),

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
                InfoAnimeEvent(malId: data.malId!),
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
                  time: '${data.type ?? 'N/A'}, ${data.year}',
                  airing: data.status ?? 'N/A',
                  duration:
                      '${data.episodes ?? '??'} ep, ${data.duration?.split(' ').take(2).join(' ')}',
                  genres: data.genres?.map((e) => e.name!).toList() ?? [],
                  searchType: SearchType.anime,
                ),

                /// Synopsis
                ReadMoreSynopsis(text: data.synopsis ?? ''),

                /// Youtube video
                if (data.trailer?.youtubeId != null)
                  InfoYoutubeVideo(data: data),

                /// InfoBelowImage
                InfoBelowImageAnime(data: data),

                /// Adaptation
                InfoAdaptation(data: data, searchType: SearchType.anime),

                /// Characters
                InfoCharacters(
                  malId: data.malId!,
                  searchType: SearchType.anime,
                ),

                /// Anime Staff
                InfoAnimeStaff(animeStaff: widget.animeStaff),

                /// Themes
                ThemesList(
                  themesModel: widget.themesModel,
                  musicVideos: widget.musicVideos,
                ),

                /// Reviews
                // ReviewList(reviews: widget.reviews),

                /// Recommendations
                RecommendationsList(
                    searchType: SearchType.anime, malId: data.malId!),

                /// News
                InfoNewsList(
                  searchType: SearchType.anime,
                  malId: data.malId!,
                ),

                /// InfoStatisticsAnimeList
                InfoStatisticsAnimeList(
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
