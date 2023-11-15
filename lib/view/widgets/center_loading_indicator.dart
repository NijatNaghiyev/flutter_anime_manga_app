import 'package:flutter/material.dart';

import '../../constants/theme/colors.dart';

class CenterLoadingIndicator extends StatelessWidget {
  const CenterLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.primary,
        ),
        height: 50,
        width: 50,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
