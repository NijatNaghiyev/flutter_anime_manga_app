import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constants/theme/colors.dart';

class ChangePasswordWidget extends StatelessWidget {
  const ChangePasswordWidget({
    super.key,
    required this.changePasswordController,
  });

  final TextEditingController changePasswordController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'Change password',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        showGeneralDialog(
          barrierLabel: 'Change Password',
          barrierDismissible: true,
          useRootNavigator: true,
          context: context,
          pageBuilder: (context, animation, secondaryAnimation) => Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.6,
              decoration: BoxDecoration(
                color: MyColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// New Password
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: changePasswordController,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        hintText: 'New Password',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Change
                  TextButton.icon(
                    onPressed: () {
                      if (changePasswordController.text.isEmpty ||
                          changePasswordController.text.length < 6) {
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(
                            const SnackBar(
                              backgroundColor: MyColors.primary,
                              content: Text(
                                'Please enter valid new password',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        return;
                      }
                      final auth = FirebaseAuth.instance.currentUser;
                      auth!.updatePassword(changePasswordController.text);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Change',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: MyColors.primary,
                    ),
                    label: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: MyColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
