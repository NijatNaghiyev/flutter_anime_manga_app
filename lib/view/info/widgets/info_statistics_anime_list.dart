import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/data/models/info/statistics_anime.dart';
import 'package:flutter_anime_manga_app/view/info/widgets/info_statistics_score_element.dart';
import 'package:flutter_anime_manga_app/view/info/widgets/statistics_element.dart';
import 'package:intl/intl.dart';

import '../../../constants/edit_list_bottom_sheet/status_anime.dart';
import '../../../data/services/info/statistics_anime.dart';

class InfoStatisticsAnimeList extends StatefulWidget {
  const InfoStatisticsAnimeList({super.key, required this.malId});

  final int malId;

  @override
  State<InfoStatisticsAnimeList> createState() =>
      _InfoStatisticsAnimeListState();
}

class _InfoStatisticsAnimeListState extends State<InfoStatisticsAnimeList> {
  ValueNotifier<StatisticsAnimeModel?> statisticsValueNotifier =
      ValueNotifier(null);

  Future<void> initStatistics() async {
    await Future.delayed(const Duration(milliseconds: 3100));
    statisticsValueNotifier.value =
        await StatisticsAnimeService.getStatisticsAnime(malId: widget.malId);

    await Future.delayed(const Duration(milliseconds: 700));
    statisticsValueNotifier.value ??=
        await StatisticsAnimeService.getStatisticsAnime(malId: widget.malId);
  }

  @override
  Widget build(BuildContext context) {
    initStatistics();

    final formatter = NumberFormat('#,###,###');

    return ValueListenableBuilder(
      valueListenable: statisticsValueNotifier,
      builder: (context, value, child) {
        return value == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: MyColors.primary,
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Statistics',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      /// Status
                      StatisticsElement(
                          title: '${StatusAnime.watching}:', value: value),
                      StatisticsElement(
                          title: '${StatusAnime.completed}:', value: value),
                      StatisticsElement(
                          title: '${StatusAnime.onHold}:', value: value),
                      StatisticsElement(
                          title: '${StatusAnime.dropped}:', value: value),
                      StatisticsElement(
                          title: '${StatusAnime.planToWatch}:', value: value),
                      Text(
                        'All members: ${formatter.format(value.total ?? 0)}',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// Score
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.scores?.length ?? 10,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return InfoStatisticsScoreElement(
                            title: index + 1,
                            percentage: value.scores![index].percentage ?? 0,
                            votes: value.scores![index].votes ?? 0,
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Scored members: ${formatter.format(value.scores?.fold(0, (previousValue, element) {
                              int nextElement = element.votes ?? 0;
                              return previousValue + nextElement;
                            }) ?? 0)}',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 13,
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
