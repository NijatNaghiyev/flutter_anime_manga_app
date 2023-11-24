import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/enum/search_type.dart';
import 'package:flutter_anime_manga_app/features/router/routers.dart';
import 'package:flutter_anime_manga_app/view/screens/login/login_screen.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/top_list/top_manga_see_all.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/top_list/top_people_see_all.dart';
import 'package:flutter_anime_manga_app/view/screens/signup/signup_screen.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/top_data/top_anime_model.dart';
import '../../view/screens/core/core_screen.dart';
import '../../view/screens/home/home_screen.dart';
import '../../view/screens/info/info_screen.dart';
import '../../view/screens/mylist/mylist_screen.dart';
import '../../view/screens/search/search_screen.dart';
import '../../view/screens/search/widgets/top_list/top_anime_see_all.dart';
import '../../view/screens/search/widgets/top_list/top_characters_see_all.dart';
import '../../view/screens/seasonal/seasonal_screen.dart';
import '../../view/screens/started/started_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKeyHome = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellNavigatorKeySearch =
    GlobalKey<NavigatorState>(debugLabel: 'search');
final _shellNavigatorKeySeasonal =
    GlobalKey<NavigatorState>(debugLabel: 'seasonal');
final _shellNavigatorKeyMylist =
    GlobalKey<NavigatorState>(debugLabel: 'mylist');

class AppRouter {
  AppRouter._();

  static GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      /// If the user is logged in, redirect to the home page
      if (FirebaseAuth.instance.currentUser != null &&
          _shellNavigatorKeyHome.currentState == null) {
        return '/home';
      }
      return null;
    },
    routes: [
      /// Started
      GoRoute(
        name: MyRouters.started.name,
        path: '/',
        builder: (context, state) => const StartedScreen(),
        routes: [
          GoRoute(
            name: MyRouters.login.name,
            path: 'login',
            pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 400),
              key: state.pageKey,
              child: const LoginScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          ),
          GoRoute(
            name: MyRouters.signup.name,
            path: 'signup',
            builder: (context, state) => const SignupScreen(),
          ),
        ],
      ),

      /// Info
      GoRoute(
        name: MyRouters.info.name,
        path: '/info',
        builder: (context, state) {
          Map<String, dynamic> infoScreenData =
              state.extra as Map<String, dynamic>;
          return InfoScreen(
            malId: infoScreenData['malId'] as int,
            type: infoScreenData['type'] as SearchType,
          );
        },
      ),

      /// Core
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return CoreScreen(navigationShell: navigationShell);
        },
        branches: [
          /// Home
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKeyHome,
            initialLocation: '/home',
            routes: [
              GoRoute(
                name: MyRouters.home.name,
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          /// Search
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKeySearch,
            initialLocation: '/search',
            routes: [
              GoRoute(
                name: MyRouters.search.name,
                path: '/search',
                builder: (context, state) => const SearchScreen(),
              ),
              GoRoute(
                name: MyRouters.animeSeeAll.name,
                path: '/animeSeeAll',
                builder: (context, state) {
                  final stateData = state.extra as List<Datum>;
                  return TopAnimeSeeAll(
                    stateData: stateData,
                  );
                },
              ),
              GoRoute(
                name: MyRouters.mangaSeeAll.name,
                path: '/mangaSeeAll',
                builder: (context, state) {
                  final stateData = state.extra as List;
                  return TopMangaSeeAll(
                    stateData: stateData,
                  );
                },
              ),
              GoRoute(
                name: MyRouters.peopleSeeAll.name,
                path: '/peopleSeeAll',
                builder: (context, state) {
                  final stateData = state.extra as List;
                  return TopPeopleSeeAll(
                    stateData: stateData,
                  );
                },
              ),
              GoRoute(
                name: MyRouters.charactersSeeAll.name,
                path: '/charactersSeeAll',
                builder: (context, state) {
                  final stateData = state.extra as List;
                  return TopCharactersSeeAll(
                    stateData: stateData,
                  );
                },
              ),
            ],
          ),

          /// Seasonal
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKeySeasonal,
            initialLocation: '/seasonal',
            routes: [
              GoRoute(
                name: MyRouters.seasonal.name,
                path: '/seasonal',
                builder: (context, state) => const SeasonalScreen(),
              ),
            ],
          ),

          /// Mylist
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKeyMylist,
            initialLocation: '/mylist',
            routes: [
              GoRoute(
                name: MyRouters.mylist.name,
                path: '/mylist',
                builder: (context, state) => const MylistScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
