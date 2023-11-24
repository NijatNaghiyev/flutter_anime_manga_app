import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/view/screens/core/core_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/state/cubit/drawer/drawer_image_cubit.dart';

Builder buildOpenDrawer(BuildContext context) {
  return Builder(builder: (context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        scaffoldKey.currentState?.openDrawer();
      },
      icon: BlocBuilder<DrawerImageCubit, String?>(
        builder: (context, state) {
          if (state == null) {
            return const Center(
              child: Center(
                child: Icon(Icons.person, size: 30, color: Colors.white),
              ),
            );
          }

          return CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            foregroundImage: imageWidget(state),
          );
        },
      ),
    );
  });
}
