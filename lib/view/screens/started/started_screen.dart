// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/data/services/auth/auth_service.dart';
import 'package:flutter_anime_manga_app/features/router/routers.dart';
import 'package:flutter_anime_manga_app/view/screens/started/widgets/custom_elevated_button.dart';
import 'package:go_router/go_router.dart';

class StartedScreen extends StatefulWidget {
  const StartedScreen({super.key});

  @override
  State<StartedScreen> createState() => _StartedScreenState();
}

class _StartedScreenState extends State<StartedScreen> {
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Started'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomElevatedButton(
            text: 'Sign up',
            onPressed: () => context.pushNamed(MyRouters.signup.name),
            icon: Icon(Icons.app_registration),
          ),
          CustomElevatedButton(
            text: 'Login',
            onPressed: () => context.pushNamed(MyRouters.login.name),
            icon: Icon(Icons.login),
          ),
        ],
      ),
    );
  }
}
