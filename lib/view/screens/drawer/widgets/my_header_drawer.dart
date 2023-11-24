import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/features/state/cubit/drawer/drawer_image_cubit.dart';
import 'package:flutter_anime_manga_app/view/screens/core/core_screen.dart';
import 'package:flutter_anime_manga_app/view/screens/profile/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme/colors.dart';

class MyHeaderDrawer extends StatelessWidget {
  const MyHeaderDrawer({super.key});

  String userName() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? 'UnKnown';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        scaffoldKey.currentState?.closeDrawer();

        showModalBottomSheet(
          clipBehavior: Clip.hardEdge,
          useRootNavigator: true,
          enableDrag: true,
          isScrollControlled: true,
          useSafeArea: true,
          context: context,
          builder: (context) => const ProfileScreen(),
        );
      },
      child: DrawerHeader(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<DrawerImageCubit, String?>(
              builder: (context, state) {
                if (state == null) {
                  return const Center(
                    child: Center(
                      child: Icon(Icons.person, size: 100, color: Colors.white),
                    ),
                  );
                }
                return CircleAvatar(
                  backgroundColor: MyColors.primary,
                  radius: 50,
                  foregroundImage: imageWidget(state),
                );
              },
            ),
            Column(
              children: [
                const Spacer(),
                Text(
                  userName(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Profile',
                  style: TextStyle(
                    color: MyColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
