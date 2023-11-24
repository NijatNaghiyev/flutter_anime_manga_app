import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:numberpicker/numberpicker.dart';

import 'edit_list_bottom_sheet.dart';

class BottomSheetProgressNumber extends StatelessWidget {
  const BottomSheetProgressNumber({
    super.key,
    required this.widgetEditBottomSheet,
    required this.onSelectedNumber,
  });

  final EditListBottomSheet widgetEditBottomSheet;
  final void Function(int selectedNumber) onSelectedNumber;

  @override
  Widget build(BuildContext context) {
    ValueNotifier selectedNumber =
        ValueNotifier(widgetEditBottomSheet.mylistModel.userProgress);
    return ValueListenableBuilder(
        valueListenable: selectedNumber,
        builder: (context, value, _) {
          return SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
            child: NumberPicker(
              axis: Axis.horizontal,
              step: 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: MyColors.primary,
                  width: 2,
                ),
              ),
              selectedTextStyle: const TextStyle(
                color: MyColors.primary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textStyle: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.color
                    ?.withOpacity(0.7),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              minValue: 0,
              maxValue: widgetEditBottomSheet.mylistModel.episodesOrChapters ??
                  99999999,
              value: value,
              onChanged: (value) {
                selectedNumber.value = value;
                onSelectedNumber(value);
              },
            ),
          );
        });
  }
}
