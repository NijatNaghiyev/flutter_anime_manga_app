import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/data/models/anime/recent_reviews_anime_model.dart';
import 'package:flutter_anime_manga_app/view/screens/webview/webview_screen.dart';
import 'package:intl/intl.dart';

import '../../../../constants/enum/search_type.dart';
import '../../info/info_screen.dart';

class RecentReviewsListElement extends StatefulWidget {
  const RecentReviewsListElement({super.key, required this.data});

  final data;

  @override
  State<RecentReviewsListElement> createState() =>
      _RecentReviewsListElementState();
}

class _RecentReviewsListElementState extends State<RecentReviewsListElement> {
  final formatter = DateFormat('dd MMM, yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: MyColors.primary.withOpacity(0.5),
      child: Row(
        children: [
          OpenContainer(
            transitionDuration: const Duration(milliseconds: 500),
            openBuilder: (context, action) {
              return InfoScreen(
                malId: widget.data.entry.malId,
                type: widget.data is RecentReviewsAnimeModel
                    ? SearchType.anime
                    : SearchType.manga,
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
            closedBuilder: (context, action) => SizedBox(
              height: 130,
              width: 90,
              child: Image.network(
                widget.data.entry.images['jpg']?.imageUrl ?? '',
                cacheHeight: 130,
                cacheWidth: 90,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(child: CircularProgressIndicator());
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: OpenContainer(
              transitionDuration: const Duration(milliseconds: 500),
              openBuilder: (context, action) {
                return WebviewScreen(
                  url: widget.data.url,
                );
              },
              clipBehavior: Clip.hardEdge,
              closedColor: Colors.transparent,
              closedElevation: 0,
              // * important
              useRootNavigator: true,
              onClosed: (data) {},
              closedBuilder: (context, action) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: widget.data.entry.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: '   ${formatter.format(widget.data.date)}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text:
                              '  ${widget.data is RecentReviewsAnimeModel ? 'ANIME' : 'MANGA'}',
                          style: TextStyle(
                            color: widget.data is RecentReviewsAnimeModel
                                ? MyColors.animeTypeColor
                                : MyColors.mangaTypeColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.data.review,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Review by  ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: widget.data.user.username,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
