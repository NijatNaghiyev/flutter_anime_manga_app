import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/view/screens/settings/widgets/appearance_widget.dart';
import 'package:flutter_anime_manga_app/view/screens/settings/widgets/change_password_widget.dart';
import 'package:flutter_anime_manga_app/view/screens/settings/widgets/delete_account_widget.dart';
import 'package:flutter_anime_manga_app/view/screens/settings/widgets/version_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController changePasswordController;

  @override
  void initState() {
    changePasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    changePasswordController.dispose();
    super.dispose();
  }

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

            /// Appearance
            const AppearanceWidget(),

            const Divider(height: 1),

            /// Change Password
            ChangePasswordWidget(
                changePasswordController: changePasswordController),

            const Divider(),

            /// Delete Account
            const DeleteAccountWidget(),

            const Divider(),

            /// Version
            const VersionWidget(),
          ],
        ),
      ),
    );
  }
}
