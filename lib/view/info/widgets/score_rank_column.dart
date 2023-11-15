import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScoreRankColumn extends StatelessWidget {
  const ScoreRankColumn({super.key, required this.data});

  final data;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,###,###');

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Score',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.star,
              size: 16,
            ),
            Text(
              '${data.score ?? 'N/A'}',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Rank',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          '#${data.rank}',
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Members',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          formatter.format(data.members).toString(),
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          formatter.format(data.favorites).toString(),
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
