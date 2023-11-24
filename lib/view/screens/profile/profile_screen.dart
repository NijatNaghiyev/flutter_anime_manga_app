// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/view/screens/profile/widgets/created_and_last_login_date.dart';
import 'package:flutter_anime_manga_app/view/screens/profile/widgets/favorite_list.dart';
import 'package:flutter_anime_manga_app/view/screens/profile/widgets/profile_anime_entries.dart';
import 'package:flutter_anime_manga_app/view/screens/profile/widgets/profile_app_bar.dart';
import 'package:flutter_anime_manga_app/view/screens/profile/widgets/profile_manga_entries.dart';
import 'package:flutter_anime_manga_app/view/screens/profile/widgets/profile_name_and_email.dart';
import 'package:flutter_anime_manga_app/view/screens/profile/widgets/profile_photo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            ProfileAppBar(),
            Divider(height: 0),
            Row(
              children: [
                /// Profile Photo
                Expanded(
                  child: ProfilePhoto(),
                ),

                /// Name and Email
                ProfileNameAndEmail(),
              ],
            ),

            /// Created and Last Login Date
            CreatedAndLastLoginDate(),

            /// Profile Anime Entries
            ProfileAnimeEntries(),

            /// Profile manga Entries
            ProfileMangaEntries(),

            /// Favorite List TabBarView
            FavoriteList(),
          ],
        ),
      ),
    );
  }
}
