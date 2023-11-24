import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/theme/colors.dart';
import '../../../../my_app.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        leading: const CloseButton(),
        title: const Text(
          'Appearance',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedThemeValueNotifier,
        builder: (context, theme, _) {
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(height: 1),
                  ListTile(
                    title: const Text(
                      'Light',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: theme == 0
                        ? const Icon(
                            Icons.check,
                            color: MyColors.primary,
                          )
                        : const SizedBox.shrink(),
                    onTap: () async {
                      final pref = await SharedPreferences.getInstance();
                      await pref.setInt('theme', 0);
                      selectedThemeValueNotifier.value = 0;
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Dark',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: theme == 1
                        ? const Icon(
                            Icons.check,
                            color: MyColors.primary,
                          )
                        : const SizedBox.shrink(),
                    onTap: () async {
                      final pref = await SharedPreferences.getInstance();
                      await pref.setInt('theme', 1);
                      selectedThemeValueNotifier.value = 1;
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'System',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: theme == 2
                        ? const Icon(
                            Icons.check,
                            color: MyColors.primary,
                          )
                        : const SizedBox.shrink(),
                    onTap: () async {
                      final pref = await SharedPreferences.getInstance();
                      await pref.setInt('theme', 2);
                      selectedThemeValueNotifier.value = 2;
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
