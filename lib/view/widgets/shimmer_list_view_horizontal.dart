import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListViewHorizontal extends StatelessWidget {
  const ShimmerListViewHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey,
          enabled: true,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.red,
              ),
              width: MediaQuery.sizeOf(context).width * 0.4,
              height: MediaQuery.sizeOf(context).height * 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
