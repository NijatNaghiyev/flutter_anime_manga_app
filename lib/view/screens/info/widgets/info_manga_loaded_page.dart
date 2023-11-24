import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/enum/search_type.dart';
import 'package:flutter_anime_manga_app/data/models/manga/manga_full_model.dart';
import 'package:flutter_anime_manga_app/view/screens/info/widgets/read_more_synopsis.dart';
import 'package:flutter_anime_manga_app/view/screens/info/widgets/recommendations_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../constants/edit_list_bottom_sheet/status_colors.dart';
import '../../../../constants/edit_list_bottom_sheet/status_manga.dart';
import '../../../../constants/theme/colors.dart';
import '../../../../data/models/mylist/mylist_model.dart';
import '../../../../data/services/firestore_database/favorite_manga_firebase.dart';
import '../../../../data/services/firestore_database/mylist_manga_store.dart';
import '../../../../features/state/bloc/info/info_bloc/info_bloc.dart';
import '../../../widgets/show_edit_list_bottom_sheet.dart';
import 'favorite_icon_value_listenable.dart';
import 'image_row.dart';
import 'info_adaptation.dart';
import 'info_below_image_manga.dart';
import 'info_characters.dart';
import 'info_initial_area.dart';
import 'info_news_list.dart';
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
  ValueNotifier<List<MylistModel>> mylistValueNotifier = ValueNotifier([]);

  Future<void> initData() async {
    await FavoriteMangaFirebaseService.getFavoriteMangaList()
        .then((value) => favoriteAnimeMangaListValueNotifier.value = {
              'anime': favoriteAnimeMangaListValueNotifier.value['anime']!,
              'manga': value,
            });

    await MylistMangaStore.getMylist()
        .then((value) => mylistValueNotifier.value = value);
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.mangaFullModel.data!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: ValueListenableBuilder(
          valueListenable: mylistValueNotifier,
          builder: (context, value, _) {
            if (value.isEmpty) {
              return const SizedBox.shrink();
            }

            return FloatingActionButton(
              onPressed: () async {
                await showEditListBottomSheet(
                  context: context,
                  type: SearchType.manga,
                  mylistModel: MylistModel(
                    malId: data.malId!,
                    animeOrManga: SearchType.manga.name,
                    imageUrl: data.images!['jpg']!.imageUrl!,
                    title: data.title!,
                    type: data.type!,
                    userStatus:
                        value.any((element) => element.malId == data.malId)
                            ? value
                                .firstWhere(
                                    (element) => element.malId == data.malId)
                                .userStatus!
                            : null,
                    airingStart: data.published!.string!,
                    episodesOrChapters: data.chapters,
                    userProgress: null,
                    userScore: null,
                    userStartDate: null,
                    userEndDate: null,
                    addedTime: null,
                  ),
                );
                await MylistMangaStore.getMylist()
                    .then((value) => mylistValueNotifier.value = value);
              },
              backgroundColor: value
                      .any((element) => element.malId == data.malId)
                  ? StatusColors.statusColors[StatusManga.statusList.indexOf(
                      value
                          .firstWhere((element) => element.malId == data.malId)
                          .userStatus!)]
                  : MyColors.primary,
              child: const Icon(
                Icons.edit_note,
                color: Colors.white,
                size: 32,
              ),
            );
          }),
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
                  searchType: SearchType.manga,
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
