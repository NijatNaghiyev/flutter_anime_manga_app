import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/enum/search_type.dart';
import 'package:flutter_anime_manga_app/data/services/info/recommendations_anime.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/info/recommendation_model.dart';
import '../../../../data/services/info/anime_full.dart';
import '../../../../data/services/info/manga_full.dart';
import '../../../../data/services/info/recommendationss_manga.dart';
import '../../../../features/state/bloc/info/info_bloc/info_bloc.dart';
import '../info_screen.dart';

class RecommendationsList extends StatefulWidget {
  const RecommendationsList({
    super.key,
    required this.searchType,
    required this.malId,
  });

  final SearchType searchType;
  final int malId;

  @override
  State<RecommendationsList> createState() => _RecommendationsListState();
}

class _RecommendationsListState extends State<RecommendationsList> {
  ValueNotifier<List<RecommendationModel>> recommendationsValueNotifier =
      ValueNotifier([]);

  Future<void> initRecommendations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (widget.searchType == SearchType.anime) {
      RecommendationsAnimeService.getRecommendations(malId: widget.malId)
          .then((value) => recommendationsValueNotifier.value = value);
    } else {
      RecommendationsMangaService.getRecommendations(malId: widget.malId)
          .then((value) => recommendationsValueNotifier.value = value);
    }
  }

  @override
  void initState() {
    super.initState();
    initRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ValueListenableBuilder(
          valueListenable: recommendationsValueNotifier,
          builder: (context, value, _) {
            if (value.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'Recommendations',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: SizedBox(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        final data = value[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BlocProvider<InfoBloc>(
                                      create: (context) => InfoBloc(
                                        animeFullService:
                                            context.read<AnimeFullService>(),
                                        mangaFullService:
                                            context.read<MangaFullService>(),
                                      ),
                                      child: InfoScreen(
                                        malId: data.malId,
                                        type: widget.searchType,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: SizedBox(
                                height: 200,
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.network(
                                        data.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                            child: Icon(Icons.error),
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.6),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        left: 5,
                                        right: 5,
                                        child: SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.3,
                                          child: Text(
                                            data.title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  '${data.votes?.toString() ?? 'N/A'} votes',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
