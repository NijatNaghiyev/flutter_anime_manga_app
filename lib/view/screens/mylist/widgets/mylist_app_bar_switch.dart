import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../../../../constants/enum/search_type.dart';
import '../../../../constants/theme/colors.dart';

final ValueNotifier<SearchType> animeOrManga =
    ValueNotifier<SearchType>(SearchType.anime);

class MylistAppBarSwitch extends StatelessWidget {
  const MylistAppBarSwitch({
    super.key,
    required ValueNotifier<bool> isSwitched,
  }) : _isSwitched = isSwitched;

  final ValueNotifier<bool> _isSwitched;

  void showToastSwitch({required String type}) {
    showToast(
      'Switched to $type',
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      textPadding: const EdgeInsets.all(16.0),
      backgroundColor: MyColors.primary.withOpacity(0.6),
      position: ToastPosition.center,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: const Duration(milliseconds: 600),
      duration: const Duration(seconds: 3),
      dismissOtherToast: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder(
        valueListenable: _isSwitched,
        builder: (context, value, _) {
          return Row(
            children: [
              const Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Switch(
                activeColor: Colors.white,
                activeTrackColor: MyColors.scaffoldBackground,
                inactiveTrackColor: Theme.of(context).scaffoldBackgroundColor,
                value: value,
                onChanged: (value) {
                  _isSwitched.value = value;
                  if (value) {
                    animeOrManga.value = SearchType.manga;
                    showToastSwitch(type: 'Manga');
                  } else {
                    animeOrManga.value = SearchType.anime;
                    showToastSwitch(type: 'Anime');
                  }
                },
              ),
              const Text(
                'M',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
