import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/theme/colors.dart';

class ListViewHorizontalPeople extends StatelessWidget {
  const ListViewHorizontalPeople({
    super.key,
    required this.topPeopleData,
  });

  final List topPeopleData;

  @override
  Widget build(BuildContext context) {
    final formatter =
        NumberFormat.compact(locale: "en_US", explicitSign: false);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: topPeopleData.length,
        itemBuilder: (context, index) {
          final topDataIndex = topPeopleData[index];
          return Container(
            margin: const EdgeInsets.all(5),
            width: MediaQuery.sizeOf(context).width * 0.4,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.hardEdge,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    topDataIndex.images.jpg.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: MyColors.primary,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: CircleAvatar(
                    backgroundColor:
                        MyColors.scaffoldBackground.withOpacity(0.7),
                    child: Text(
                      (index + 1).toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    height: MediaQuery.sizeOf(context).height * 0.07,
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topDataIndex.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              formatter.format(topDataIndex.favorites),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.favorite,
                              size: 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
