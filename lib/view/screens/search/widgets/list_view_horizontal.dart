import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anime_manga_app/features/state/cubit/core/bottom_nav_bar_cubit.dart';
import 'package:flutter_anime_manga_app/view/info/info_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../constants/enum/search_type.dart';
import '../../../../constants/theme/colors.dart';
import '../../../../features/router/routers.dart';
import '../../../../features/state/bloc/info/info_bloc/info_bloc.dart';

/// Go to Info Screen
void goToInfoScreen(BuildContext context, int malId, SearchType type) {
  context.read<BottomNavBarCubit>().changeState(false);

  GoRouter.of(context).pushNamed(
    MyRouters.info.name,
    extra: {
      'malId': malId,
      'type': SearchType.anime,
    },
  );
}

class ListViewHorizontal extends StatelessWidget {
  const ListViewHorizontal(
      {super.key, required this.topData, required this.type});

  final List topData;

  final SearchType type;

  @override
  Widget build(BuildContext context) {
    final formatter =
        NumberFormat.compact(locale: "en_US", explicitSign: false);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: topData.length,
        itemBuilder: (context, index) {
          final topDataIndex = topData[index];
          return OpenContainer(
            transitionDuration: const Duration(milliseconds: 500),
            openBuilder: (context, action) {
              return InfoScreen(
                malId: topDataIndex.malId,
                type: type,
              );
            },
            clipBehavior: Clip.hardEdge,
            closedColor: Colors.transparent,
            closedElevation: 0,
            // * important
            useRootNavigator: true,
            onClosed: (data) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown
              ]);
            },
            closedBuilder: (context, action) => Container(
              margin: const EdgeInsets.all(5),
              width: MediaQuery.sizeOf(context).width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.hardEdge,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                      topDataIndex.images['jpg']?.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            color: MyColors.primary,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: CircleAvatar(
                      backgroundColor:
                          MyColors.scaffoldBackground.withOpacity(0.7),
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      height: MediaQuery.sizeOf(context).height * 0.075,
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            child: Text(
                              topDataIndex.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                formatter.format(topDataIndex.scoredBy),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(Icons.people_alt_sharp, size: 11),
                              const Spacer(),
                              Text(
                                topDataIndex.score.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                size: 11,
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
