import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/info/news_model.dart';
import '../../webview/webview_screen.dart';

class HomeNewsListElement extends StatelessWidget {
  const HomeNewsListElement({super.key, required this.data});

  final NewsModel data;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMM, yyyy HH:mm');
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (context, action) {
        return WebviewScreen(
          url: data.url!,
        );
      },
      clipBehavior: Clip.hardEdge,
      closedColor: Colors.transparent,
      closedElevation: 0,
      // * important
      useRootNavigator: true,
      closedBuilder: (context, action) => Card(
        color: MyColors.primary.withOpacity(0.5),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            Container(
              height: 130,
              width: 90,
              margin: const EdgeInsets.only(left: 4, right: 10),
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                data.images?.jpg?.imageUrl ?? '',
                cacheHeight: 130,
                cacheWidth: 90,
                fit: BoxFit.cover,
                scale: 1,
                alignment: Alignment.center,
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
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 1),
                    Row(
                      children: [
                        const Text(
                          'More Info  ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          formatter.format(data.date!),
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      children: [
                        Text(
                          'New Topic: ${data.title}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.newspaper,
                              color: Colors.white.withOpacity(0.6),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.6),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'More',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            'Comments: ${data.comments}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
