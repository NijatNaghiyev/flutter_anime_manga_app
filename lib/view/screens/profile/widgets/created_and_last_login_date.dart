import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:intl/intl.dart';

class CreatedAndLastLoginDate extends StatelessWidget {
  const CreatedAndLastLoginDate({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMM, yyyy HH:mm');
    final user = FirebaseAuth.instance.currentUser;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text(
                'Created',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.primary,
                ),
              ),
              Text(
                formatter.format(
                  user?.metadata.creationTime ?? DateTime(0),
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              const Text(
                'Last Login',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.primary,
                ),
              ),
              Text(
                formatter.format(
                  user?.metadata.lastSignInTime ?? DateTime(0),
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
