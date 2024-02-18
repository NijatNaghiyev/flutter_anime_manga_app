import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/features/bloc/multi_providers.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/theme/my_theme.dart';
import 'features/bloc/multi_rep_providers.dart';
import 'features/router/app_router.dart';

/// Selected Theme
late SharedPreferences pref;
ValueNotifier<int> selectedThemeValueNotifier =
    ValueNotifier(pref.getInt('theme') ?? 1);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// MultiRepProviders
    return MultiRepProviders(
      /// Providers
      child: MultiProviders(
        child: OKToast(
          child: ValueListenableBuilder(
              valueListenable: selectedThemeValueNotifier,
              builder: (context, theme, _) {
                var selectedTheme = ThemeMode.dark;
                if (theme == 0) {
                  selectedTheme = ThemeMode.light;
                } else if (theme == 1) {
                  selectedTheme = ThemeMode.dark;
                } else if (theme == 2) {
                  selectedTheme = ThemeMode.system;
                }
                return MaterialApp.router(
                  routerConfig: AppRouter.router,
                  title: 'FIMDb',
                  debugShowCheckedModeBanner: false,
                  theme: myThemeLight,
                  darkTheme: myThemeDark,
                  themeMode: selectedTheme,
                );
              }),
        ),
      ),
    );
  }
}
