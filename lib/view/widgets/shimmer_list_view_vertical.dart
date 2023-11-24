import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListViewVertical extends StatelessWidget {
  const ShimmerListViewVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: 16,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey,
          enabled: true,
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                Container(
                  height: 130,
                  width: 90,
                  color: Colors.red,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    children: [],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
