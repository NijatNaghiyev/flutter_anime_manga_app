import 'package:flutter/material.dart';

import '../../../data/models/info/review_model.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({super.key, required this.reviews});

  final List<ReviewModel> reviews;
  @override
  Widget build(BuildContext context) {
    print(reviews);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final data = reviews[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text('${data.score}/10'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
