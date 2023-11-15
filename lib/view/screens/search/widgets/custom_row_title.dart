import 'package:flutter/material.dart';

import '../../../../constants/theme/colors.dart';

class CustomRowTitle extends StatelessWidget {
  const CustomRowTitle({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onTap,
          child: Text(
            'See All',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: MyColors.primary.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }
}
