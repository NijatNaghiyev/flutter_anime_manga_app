import 'package:flutter/material.dart';

import 'appearance_page.dart';

class AppearanceWidget extends StatelessWidget {
  const AppearanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'Appearance',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        showModalBottomSheet(
          clipBehavior: Clip.hardEdge,
          useRootNavigator: true,
          enableDrag: true,
          isScrollControlled: true,
          useSafeArea: true,
          context: context,
          builder: (context) => const AppearancePage(),
        );
      },
    );
  }
}
