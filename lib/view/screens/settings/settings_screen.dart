import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/view/screens/settings/widgets/appearance_page.dart';
import 'package:go_router/go_router.dart';

import '../../../features/router/routers.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        leading: const CloseButton(),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const Divider(height: 1),
            ListTile(
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
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Delete account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                showGeneralDialog(
                  barrierLabel: 'Change Photo',
                  barrierDismissible: true,
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Center(
                    child: Container(
                      height: 210,
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      decoration: BoxDecoration(
                        color: MyColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          /// Delete
                          TextButton.icon(
                            onPressed: () async {
                              final auth = FirebaseAuth.instance.currentUser;
                              await auth!.delete();
                              context.goNamed(MyRouters.started.name);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          /// Cancel
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: MyColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Version',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Text(
                '1.0.0',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
