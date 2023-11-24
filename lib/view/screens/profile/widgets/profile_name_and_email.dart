import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../../../../constants/theme/colors.dart';

class ProfileNameAndEmail extends StatefulWidget {
  const ProfileNameAndEmail({
    super.key,
  });

  @override
  State<ProfileNameAndEmail> createState() => _ProfileNameAndEmailState();
}

class _ProfileNameAndEmailState extends State<ProfileNameAndEmail> {
  late TextEditingController textEditingController;

  void onSave() {
    if (textEditingController.text.isNotEmpty &&
        textEditingController.text !=
            FirebaseAuth.instance.currentUser!.displayName &&
        textEditingController.text.length > 3 &&
        textEditingController.text != '') {
      FirebaseAuth.instance.currentUser!
          .updateDisplayName(textEditingController.text);
    } else {
      showToast(
        'Invalid Name',
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        textPadding: const EdgeInsets.all(16.0),
        backgroundColor: MyColors.primary.withOpacity(0.6),
        position: ToastPosition.center,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: const Duration(milliseconds: 600),
        duration: const Duration(seconds: 3),
        dismissOtherToast: true,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.displayName,
    );
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// User Name
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextField(
              controller: textEditingController,
              onSubmitted: (value) => onSave(),
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: onSave,
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: FirebaseAuth.instance.currentUser!.displayName,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        /// User Email
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            FirebaseAuth.instance.currentUser!.email!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
