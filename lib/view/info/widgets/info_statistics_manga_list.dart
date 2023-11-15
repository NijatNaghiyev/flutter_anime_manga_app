import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/data/models/info/statistics_manga.dart';
import 'package:flutter_anime_manga_app/data/services/info/statistics_manga.dart';
import 'package:flutter_anime_manga_app/view/info/widgets/info_statistics_score_element.dart';
import 'package:flutter_anime_manga_app/view/info/widgets/statistics_element.dart';
import 'package:intl/intl.dart';

import '../../../constants/edit_list_bottom_sheet/status_manga.dart';
import '../../../constants/theme/colors.dart';

class InfoStatisticsMangaList extends StatefulWidget {
  const InfoStatisticsMangaList({super.key, required this.malId});

  final int malId;

  @override
  State<InfoStatisticsMangaList> createState() =>
      _InfoStatisticsMangaListState();
}

class _InfoStatisticsMangaListState extends State<InfoStatisticsMangaList> {
  ValueNotifier<StatisticsMangaModel?> statisticsValueNotifier =
      ValueNotifier(null);

  Future<void> initStatistics() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    StatisticsMangaService.getStatisticsManga(malId: widget.malId)
        .then((value) => statisticsValueNotifier.value = value);
  }

  @override
  void initState() {
    super.initState();
    initStatistics();
  }

  @override
  Widget build(BuildContext context) {
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
                          title: '${StatusManga.reading}:', value: value),
                      StatisticsElement(
                          title: '${StatusManga.completed}:', value: value),
                      StatisticsElement(
                          title: '${StatusManga.onHold}:', value: value),
                      StatisticsElement(
                          title: '${StatusManga.dropped}:', value: value),
                      StatisticsElement(
                          title: '${StatusManga.planToRead}:', value: value),
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
