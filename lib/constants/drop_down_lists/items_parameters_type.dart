import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/extensions/string.dart';

import '../enum/parameter_search_type.dart';
import '../enum/search_type.dart';

/// DropdownMenuItems for the search type
List<DropdownMenuItem> getDropDownItemsParametersType(SearchType type) {
  switch (type) {
    case SearchType.anime:
      return ParameterSearchTypeAnime.values
          .map(
            (e) => DropdownMenuItem(
              key: UniqueKey(),
              value: e.name,
              child: Text(e.name.capitalize()),
            ),
          )
          .toList();
    case SearchType.manga:
      return ParameterSearchTypeManga.values
          .map(
            (e) => DropdownMenuItem(
              key: UniqueKey(),
              value: e.name,
              child: Text(e.name.capitalize()),
            ),
          )
          .toList();
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
