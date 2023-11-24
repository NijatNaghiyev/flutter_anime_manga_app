import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/features/router/routers.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/theme/colors.dart';
import '../../../widgets/center_loading_indicator.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: TextButton(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.zero),
            ),
            onPressed: () async {
              showGeneralDialog(
                barrierDismissible: false,
                useRootNavigator: false,
                barrierLabel: 'Logout',
                barrierColor: Colors.transparent,
                context: context,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const CenterLoadingIndicator(),
              );
              await FirebaseAuth.instance.signOut();

              context.goNamed(MyRouters.started.name);
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: MyColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
