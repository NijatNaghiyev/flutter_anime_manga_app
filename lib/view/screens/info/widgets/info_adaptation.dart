import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/features/state/bloc/info/info_bloc/info_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/enum/search_type.dart';
import '../../../../data/models/anime/anime_full_model.dart';
import '../../../../data/services/info/anime_full.dart';
import '../../../../data/services/info/manga_full.dart';
import '../info_screen.dart';

class InfoAdaptation extends StatelessWidget {
  const InfoAdaptation(
      {super.key, required this.data, required this.searchType});

  final data;
  final SearchType searchType;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.relations?.length ?? 0,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    data.relations![index].relation.toString(),
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.relations![index].entry!
                        .map(
                          (e) {
                            return GestureDetector(
                              onTap: () {
                                final sType = e.type == Type.ANIME
                                    ? SearchType.anime
                                    : SearchType.manga;
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        BlocProvider<InfoBloc>(
                                      create: (context) => InfoBloc(
                                        animeFullService:
                                            context.read<AnimeFullService>(),
                                        mangaFullService:
                                            context.read<MangaFullService>(),
                                      ),
                                      child: InfoScreen(
                                        malId: e.malId!,
                                        type: sType,
                                      ),
                                    ),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return SharedAxisTransition(
                                        animation: animation,
                                        secondaryAnimation: secondaryAnimation,
                                        transitionType:
                                            SharedAxisTransitionType.vertical,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Text(
                                  e.name ?? 'N/A',
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: MyColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                        .toList()
                        .cast<Widget>(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
