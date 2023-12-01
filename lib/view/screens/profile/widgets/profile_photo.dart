import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/view/screens/profile/widgets/build_change_photo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme/colors.dart';
import '../../../../features/state/cubit/drawer/drawer_image_cubit.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({super.key});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerImageCubit, String?>(
      builder: (context, state) {
        /// If state is null or empty
        if (state == null || state.isEmpty) {
          return Container(
            margin: const EdgeInsets.all(10),
            height: 240,
            width: 180,
            decoration: const BoxDecoration(
              color: MyColors.primary,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: const EdgeInsets.all(8),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    shape: MaterialStateProperty.all(
                      const CircleBorder(),
                    ),
                  ),
                  onPressed: () async {
                    /// Change Photo
                    changePhoto(context);
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          );
        }

        /// Photo Loaded
        return Container(
          margin: const EdgeInsets.all(10),
          height: 240,
          width: 180,
          decoration: BoxDecoration(
            color: MyColors.primary,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              alignment: Alignment.center,
              image: imageWidget(state),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                padding: const EdgeInsets.all(8),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black54),
                  shape: MaterialStateProperty.all(
                    const CircleBorder(),
                  ),
                ),
                onPressed: () async {
                  /// Change Photo
                  changePhoto(context);
                },
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
