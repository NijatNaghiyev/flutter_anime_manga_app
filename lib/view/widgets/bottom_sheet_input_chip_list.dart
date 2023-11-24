import 'package:flutter/material.dart';

import '../../constants/edit_list_bottom_sheet/status_anime.dart';
import '../../constants/edit_list_bottom_sheet/status_colors.dart';
import '../../constants/edit_list_bottom_sheet/status_manga.dart';
import '../../constants/enum/search_type.dart';

/// List of [InputChip] for status.

List<ChoiceChip> statusList(
    {required SearchType type,
    required String selectedStatus,
    required ValueNotifier<String> selectedStatusValueNotifier,
    required BuildContext context}) {
  if (type == SearchType.anime) {
    return StatusAnime.statusList.map((e) {
      return ChoiceChip(
        label: Text(
          e,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall!.color,
          ),
        ),
        selected: selectedStatus == e,
        color: selectedStatus == e
            ? MaterialStatePropertyAll(
                StatusColors.statusColors[StatusAnime.statusList.indexOf(e)])
            : MaterialStatePropertyAll(
                Theme.of(context).scaffoldBackgroundColor,
              ),
        showCheckmark: false,
        onSelected: (bool value) {
          selectedStatusValueNotifier.value = e;
        },
      );
    }).toList();
  } else if (type == SearchType.manga) {
    return StatusManga.statusList.map((e) {
      return ChoiceChip(
        label: Text(
          e,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall!.color,
          ),
        ),
        selected: selectedStatus == e,
        color: selectedStatus == e
            ? MaterialStatePropertyAll(
                StatusColors.statusColors[StatusManga.statusList.indexOf(e)])
            : MaterialStatePropertyAll(
                Theme.of(context).scaffoldBackgroundColor,
              ),
        showCheckmark: false,
        onSelected: (bool value) {
          selectedStatusValueNotifier.value = e;
        },
      );
    }).toList();
  }
  return [];
}
