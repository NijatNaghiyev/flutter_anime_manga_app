import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/enum/search_type.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/data/models/info/news_model.dart';
import 'package:flutter_anime_manga_app/data/services/info/news_anime.dart';
import 'package:flutter_anime_manga_app/data/services/info/news_manga.dart';
import 'package:intl/intl.dart';

import '../../webview/webview_screen.dart';

class InfoNewsList extends StatefulWidget {
  const InfoNewsList(
      {super.key, required this.searchType, required this.malId});

  final SearchType searchType;
  final int malId;

  @override
  State<InfoNewsList> createState() => _InfoNewsListState();
}

class _InfoNewsListState extends State<InfoNewsList> {
  ValueNotifier<List<NewsModel>> newsValueNotifier = ValueNotifier([]);

  Future<void> initData() async {
    await Future.delayed(const Duration(milliseconds: 2700));

    log('${newsValueNotifier.value} News');
    if (newsValueNotifier.value.isEmpty) {
      log('true News');

      if (widget.searchType == SearchType.anime) {
        newsValueNotifier.value =
            await NewsAnimeService.getNews(malId: widget.malId);

        await Future.delayed(const Duration(milliseconds: 600));
      } else {
        newsValueNotifier.value =
            await NewsMangaService.getNews(malId: widget.malId);

        await Future.delayed(const Duration(milliseconds: 600));
      }
    } else {
      log('Break News');
    }
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMMM, yyyy');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: newsValueNotifier,
          builder: (context, value, _) {
            if (value.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'News',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        ValueListenableBuilder(
            valueListenable: newsValueNotifier,
            builder: (context, value, _) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.isNotEmpty ? 2 : 0,
                itemBuilder: (context, index) {
                  final data = value[index];

                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            WebviewScreen(url: data.url ?? ''),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.vertical,
                            child: child,
                          );
                        },
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      child: SizedBox(
                        height: 170,
                        child: Row(
                          children: [
                            Image.network(
                              data.images!.jpg!.imageUrl ?? '',
                              fit: BoxFit.cover,
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              height: 170,
                              errorBuilder: (context, error, stackTrace) {
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
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    data.title ?? '',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.primaryLight,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    data.excerpt ?? '',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatter.format(data.date!),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${data.comments ?? 'N/A'} comments.',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ],
    );
  }
}
