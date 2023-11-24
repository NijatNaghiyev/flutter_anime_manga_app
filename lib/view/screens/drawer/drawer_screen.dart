import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/view/screens/drawer/widgets/logout_button.dart';
import 'package:flutter_anime_manga_app/view/screens/drawer/widgets/my_header_drawer.dart';
import 'package:flutter_anime_manga_app/view/screens/settings/settings_screen.dart';
import 'package:flutter_anime_manga_app/view/screens/webview/webview_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Drawer Header
          const MyHeaderDrawer(),

          Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListTile(
              onTap: () {
                showModalBottomSheet(
                  clipBehavior: Clip.hardEdge,
                  useRootNavigator: true,
                  enableDrag: true,
                  isScrollControlled: true,
                  useSafeArea: true,
                  context: context,
                  builder: (context) => const SettingsScreen(),
                );
              },
              title: const Text('Settings'),
              trailing: const Icon(Icons.settings),
            ),
          ),
          Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WebviewScreen(
                        url: 'https://myanimelist.net/about.php?go=contact'),
                  ),
                );
              },
              title: const Text('Contact Support'),
              trailing: const Icon(Icons.contact_support_rounded),
            ),
          ),

          /// Logout Button
          const Spacer(),
          const LogoutButton(),
        ],
      ),
    );
  }
}
