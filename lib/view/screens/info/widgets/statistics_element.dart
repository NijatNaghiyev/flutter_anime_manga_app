import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/edit_list_bottom_sheet/status_anime.dart';
import 'package:intl/intl.dart';

import '../../../../constants/edit_list_bottom_sheet/status_manga.dart';
import '../../../../data/models/info/statistics_anime.dart';

class StatisticsElement extends StatefulWidget {
  const StatisticsElement({
    super.key,
    required this.value,
    required this.title,
  });

  final value;
  final String title;

  @override
  State<StatisticsElement> createState() => _StatisticsElementState();
}

class _StatisticsElementState extends State<StatisticsElement> {
  ValueNotifier<Map<String, int>> statisticsElementValueNotifier =
      ValueNotifier(
    {
      'maxNumber': 0,
      'currentNumber': 0,
    },
  );

  int maxNumberFunc() {
    List<int> numbers = [];
    if (widget.value is StatisticsAnimeModel) {
      numbers.add(widget.value?.watching ?? 0);
    } else {
      numbers.add(widget.value?.reading ?? 0);
    }
    numbers.add(widget.value?.completed ?? 0);
    numbers.add(widget.value?.onHold ?? 0);
    numbers.add(widget.value?.dropped ?? 0);
    if (widget.value is StatisticsAnimeModel) {
      numbers.add(widget.value?.planToWatch ?? 0);
    } else {
      numbers.add(widget.value?.planToRead ?? 0);
    }

    numbers.sort((a, b) => b.compareTo(a));

    statisticsElementValueNotifier.value['maxNumber'] = numbers.first;
    return numbers.first;
  }

  int currentNumberFunc() {
    if (widget.value is StatisticsAnimeModel) {
      switch (widget.title) {
        case '${StatusAnime.watching}:':
          return widget.value?.watching ?? 0;
        case '${StatusAnime.completed}:':
          return widget.value?.completed ?? 0;
        case '${StatusAnime.onHold}:':
          return widget.value?.onHold ?? 0;
        case '${StatusAnime.dropped}:':
          return widget.value?.dropped ?? 0;
        case '${StatusAnime.planToWatch}:':
          return widget.value?.planToWatch ?? 0;
        default:
          return 0;
      }
    } else {
      switch (widget.title) {
        case '${StatusManga.reading}:':
          return widget.value?.reading ?? 0;
        case '${StatusManga.completed}:':
          return widget.value?.completed ?? 0;
        case '${StatusManga.onHold}:':
          return widget.value?.onHold ?? 0;
        case '${StatusManga.dropped}:':
          return widget.value?.dropped ?? 0;
        case '${StatusManga.planToRead}:':
          return widget.value?.planToRead ?? 0;
        default:
          return 0;
      }
    }
  }

  void currentNumberForValueNotifier() {
    statisticsElementValueNotifier.value['currentNumber'] = currentNumberFunc();
  }

  @override
  void initState() {
    super.initState();

    maxNumberFunc();
    currentNumberForValueNotifier();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###,###');

    maxNumberFunc();
    currentNumberForValueNotifier();
    return ValueListenableBuilder(
        valueListenable: statisticsElementValueNotifier,
        builder: (context, numbers, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      LinearProgressIndicator(
                        value: numbers['maxNumber'] == 0
                            ? 0
                            : numbers['currentNumber']! / numbers['maxNumber']!,
                        minHeight: 24,
                        backgroundColor: Colors.transparent,
                      ),
                      Positioned(
                        right: 8,
                        child: Text(
                          formatter.format(numbers['currentNumber']).toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
