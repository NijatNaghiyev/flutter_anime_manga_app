import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/features/router/routers.dart';
import 'package:go_router/go_router.dart';

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
