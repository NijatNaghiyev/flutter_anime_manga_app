import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/features/router/routers.dart';
import 'package:flutter_anime_manga_app/view/screens/started/widgets/custom_elevated_button.dart';
import 'package:flutter_anime_manga_app/view/screens/started/widgets/shader_mask_title.dart';
import 'package:flutter_anime_manga_app/view/screens/started/widgets/started_google_sign_in.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/center_loading_indicator.dart';

class StartedScreen extends StatefulWidget {
  const StartedScreen({super.key});

  @override
  State<StartedScreen> createState() => _StartedScreenState();
}

class _StartedScreenState extends State<StartedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController.unbounded(
      vsync: this,
    )..repeat(
        min: -1,
        max: 1,
        period: const Duration(seconds: 4),
      );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          /// Lottie
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue,
                    Colors.purple,
                  ],
                  stops: [0.0, 0.7],
                ),
              ),
              child: Lottie.asset(
                'assets/lottie/circle_lottie.json',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),

          /// Blur
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: const SizedBox(),
            ),
          ),

          /// Title
          Positioned(
            top: 80,
            child: ShaderMaskTitle(controller: _controller),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomElevatedButton(
                text: 'Sign up',
                onPressed: () => context.pushNamed(MyRouters.signup.name),
                icon: const Icon(
                  Icons.app_registration,
                  color: Colors.white,
                ),
              ),
              CustomElevatedButton(
                text: 'Login',
                onPressed: () => context.pushNamed(MyRouters.login.name),
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          /// Google sign in
          Positioned(
            bottom: 100,
            child: GestureDetector(
              onTap: () async {
                showGeneralDialog(
                  barrierDismissible: false,
                  useRootNavigator: false,
                  barrierLabel: 'Login',
                  barrierColor: Colors.transparent,
                  context: context,
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const CenterLoadingIndicator(),
                );

                await AuthGoogleService.signInWithGoogle(context);
                mounted ? Navigator.pop(context) : null;
              },
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Image.asset(
                  'assets/images/google_logo.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
