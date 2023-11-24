import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/data/models/mylist/mylist_model.dart';
import 'package:intl/intl.dart';

class BottomSheetDateTime extends StatefulWidget {
  const BottomSheetDateTime({
    super.key,
    required this.onStartDateChanged,
    required this.onFinishDateChanged,
    required this.mylistModel,
  });

  final MylistModel mylistModel;
  final void Function(DateTime? startDate) onStartDateChanged;
  final void Function(DateTime? finishDate) onFinishDateChanged;

  @override
  State<BottomSheetDateTime> createState() => _BottomSheetDateTimeState();
}

class _BottomSheetDateTimeState extends State<BottomSheetDateTime> {
  final formatter = DateFormat('MMM dd, yyyy');

  ValueNotifier<String> selectedStartDateValueNotifier =
      ValueNotifier('Start Date');
  ValueNotifier<String> selectedFinishDateValueNotifier =
      ValueNotifier('Finish Date');

  void initData() async {
    if (widget.mylistModel.userStartDate != null) {
      selectedStartDateValueNotifier.value = widget.mylistModel.userStartDate!;
    }
    if (widget.mylistModel.userEndDate != null) {
      selectedFinishDateValueNotifier.value = widget.mylistModel.userEndDate!;
    }
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 3650)),
              lastDate: DateTime.now().add(
                const Duration(days: 3650),
              ),
            ).then(
              (value) => {
                if (value != null)
                  {
                    widget.onStartDateChanged(value),
                    selectedStartDateValueNotifier.value =
                        formatter.format(value),
                  }
              },
            );
          },
          child: Card(
            color: MyColors.primary,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                    valueListenable: selectedStartDateValueNotifier,
                    builder: (context, value, child) {
                      return Text(
                        value.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onStartDateChanged(DateTime.now());
                      selectedStartDateValueNotifier.value =
                          formatter.format(DateTime.now());
                    },
                    child: const Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 3650)),
              lastDate: DateTime.now().add(
                const Duration(days: 3650),
              ),
            ).then(
              (value) => {
                if (value != null)
                  {
                    widget.onFinishDateChanged(value),
                    selectedFinishDateValueNotifier.value =
                        formatter.format(value),
                  }
              },
            );
          },
          child: Card(
            color: MyColors.primary,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                    valueListenable: selectedFinishDateValueNotifier,
                    builder: (context, value, child) {
                      return Text(
                        value.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onFinishDateChanged(DateTime.now());
                      selectedFinishDateValueNotifier.value =
                          formatter.format(DateTime.now());
                    },
                    child: const Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
