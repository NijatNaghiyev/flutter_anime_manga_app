import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/features/router/routers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/enum/parameter_search_type.dart';
import '../../../features/state/bloc/home/home_screen/home_bloc.dart';
import '../../../features/state/bloc/mylist_screen/anime_list/mylist_anime_bloc.dart';
import '../../../features/state/bloc/mylist_screen/manga_list/mylist_manga_bloc.dart';
import '../../../features/state/bloc/seasonal/season_now/season_now_bloc.dart';

final class AuthService {
  AuthService._();

  /// Sign up with email and password
  static firebaseSignUp({
    required BuildContext context,
    required String email,
    required String password,
    required String displayName,
  }) async {
    final firebaseAuth = FirebaseAuth.instance;

    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.additionalUserInfo != null) {
        /// Update the user's display name
        await userCredential.user!.updateDisplayName(displayName);

        context.goNamed(MyRouters.home.name);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
        ),
      );
    }
  }

  /// Login with email and password
  static firebaseLogIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final firebaseAuth = FirebaseAuth.instance;

    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.additionalUserInfo != null) {
        context.read<HomeBloc>().add(HomeEventInitial());

        context.read<MylistAnimeBloc>().add(const MylistAnimeLoadEvent());
        context.read<MylistMangaBloc>().add(const MylistMangaLoadEvent());
        context.read<SeasonNowBloc>().add(const SeasonNowInitialEvent(
              type: ParameterSearchTypeAnime.Default,
            ));

        context.goNamed(MyRouters.home.name);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
        ),
      );
    }
  }
}
