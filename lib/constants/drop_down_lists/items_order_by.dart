import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/extensions/string.dart';

import '../enum/order_by_search_type.dart';
import '../enum/search_type.dart';

/// DropdownMenuItems for the order by
List<DropdownMenuItem> getDropDownItemsOrderBy(SearchType type) {
  switch (type) {
    case SearchType.anime:
      return OrderBySearchTypeAnimeManga.values
          .map(
            (e) => DropdownMenuItem(
              key: UniqueKey(),
              value: e.name,
              child: Text(
                e == OrderBySearchTypeAnimeManga.start_date
                    ? 'Airing date'
                    : e.name.capitalize(),
              ),
            ),
          )
          .toList();

    case SearchType.manga:
      return OrderBySearchTypeAnimeManga.values
          .map(
            (e) => DropdownMenuItem(
              key: UniqueKey(),
              value: e.name,
              child: Text(
                e == OrderBySearchTypeAnimeManga.start_date
                    ? 'Airing date'
                    : e.name.capitalize(),
              ),
            ),
          )
          .toList();

    case SearchType.characters:
      return [
        DropdownMenuItem(
          key: UniqueKey(),
          value: 'Default',
          child: const Text('Default'),
        ),
        DropdownMenuItem(
          key: UniqueKey(),
          value: 'favorites',
          child: const Text('Favorites'),
        ),
      ];

    case SearchType.people:
      return [
        DropdownMenuItem(
          key: UniqueKey(),
          value: 'Default',
          child: const Text('Default'),
        ),
        DropdownMenuItem(
          key: UniqueKey(),
          value: 'favorites',
          child: const Text('Favorites'),
        ),
      ];

    default:
      return [
        DropdownMenuItem(
          key: UniqueKey(),
          value: 'Default',
          child: const Text('Default'),
        ),
      ];
  }
}
