import 'package:flutter/material.dart';

import 'edit_list_bottom_sheet.dart';

class BottomSheetAnimeMangaTitle extends StatelessWidget {
  const BottomSheetAnimeMangaTitle({
    super.key,
    required this.widget,
  });

  final EditListBottomSheet widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: Text(
        widget.mylistModel.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodySmall?.color,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
