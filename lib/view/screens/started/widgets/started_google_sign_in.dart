import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_anime_manga_app/features/state/bloc/mylist_screen/anime_list/mylist_anime_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../constants/enum/parameter_search_type.dart';
import '../../../../features/router/routers.dart';
import '../../../../features/state/bloc/home/home_screen/home_bloc.dart';
import '../../../../features/state/bloc/mylist_screen/manga_list/mylist_manga_bloc.dart';
import '../../../../features/state/bloc/seasonal/season_now/season_now_bloc.dart';

class AuthGoogleService {
  static Future<void> signInWithGoogle(BuildContext context) async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    final googleAuth = await googleUser.authentication;

    /// Firebase Auth
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final result = await FirebaseAuth.instance.signInWithCredential(credential);
    if (result.user != null) {
      context.read<HomeBloc>().add(HomeEventInitial());

      context.read<MylistAnimeBloc>().add(const MylistAnimeLoadEvent());
      context.read<MylistMangaBloc>().add(const MylistMangaLoadEvent());
      context.read<SeasonNowBloc>().add(
            const SeasonNowInitialEvent(type: ParameterSearchTypeAnime.Default),
          );

      context.goNamed(MyRouters.home.name);
    }
  }
}
