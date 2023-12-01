import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/theme/colors.dart';
import '../../../../features/router/routers.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'Delete account',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.open_in_new),
      onTap: () {
        showGeneralDialog(
          barrierLabel: 'Change Photo',
          barrierDismissible: true,
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) => Center(
            child: Container(
              height: 210,
              width: MediaQuery.sizeOf(context).width * 0.6,
              decoration: BoxDecoration(
                color: MyColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Delete
                  TextButton.icon(
                    onPressed: () async {
                      final auth = FirebaseAuth.instance.currentUser;
                      await auth!.delete();
                      context.goNamed(MyRouters.started.name);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  /// Cancel
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: MyColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
