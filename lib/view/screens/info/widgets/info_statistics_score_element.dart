import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoStatisticsScoreElement extends StatefulWidget {
  const InfoStatisticsScoreElement(
      {super.key,
      required this.votes,
      required this.title,
      required this.percentage});

  final int votes;
  final double percentage;
  final int? title;

  @override
  State<InfoStatisticsScoreElement> createState() =>
      _InfoStatisticsScoreElementState();
}

class _InfoStatisticsScoreElementState
    extends State<InfoStatisticsScoreElement> {
  final formatter = NumberFormat('#,###,###');

  ValueNotifier<Map<String, num>> statisticsElementScoreValueNotifier =
      ValueNotifier(
    {
      'votes': 0,
      'percentage': 0.0,
    },
  );

  void scoreInit() {
    statisticsElementScoreValueNotifier.value['votes'] = widget.votes;
    statisticsElementScoreValueNotifier.value['percentage'] = widget.percentage;
  }

  @override
  void initState() {
    super.initState();
    scoreInit();
  }

  @override
  Widget build(BuildContext context) {
    scoreInit();

    return ValueListenableBuilder(
        valueListenable: statisticsElementScoreValueNotifier,
        builder: (context, numbers, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Text(
                    '${widget.title ?? ''}',
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
                        value: numbers['percentage']! / 100,
                        minHeight: 24,
                        backgroundColor: Colors.transparent,
                      ),
                      Positioned(
                        right: 8,
                        child: Text(
                          formatter.format(numbers['votes']).toString(),
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
