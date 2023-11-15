import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_filter_row.dart';
import 'package:intl/intl.dart';

class CharactersCardVertical extends StatelessWidget {
  CharactersCardVertical({
    super.key,
    required this.index,
    this.imageUrl,
    required this.title,
    this.favorites,
    this.isSearch = true,
  });

  final int index;
  final String? imageUrl;
  final String title;
  final int? favorites;
  final bool isSearch;

  final formatter = NumberFormat.compact(locale: "en_US", explicitSign: false);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index == 0 && isSearch) const SearchFilterRow(),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.15,
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.15,
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  child: Image.network(
                    imageUrl.toString(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Text(
                      //   '${episodes ?? '??'} ${searchType == SearchType.anime ? 'ep' : 'chp'}, ${aired ?? ''}',
                      // ),
                      const Spacer(),
                      if (favorites != null)
                        Row(
                          children: [
                            Text(
                              formatter.format(favorites),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.people,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_box_outlined,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
