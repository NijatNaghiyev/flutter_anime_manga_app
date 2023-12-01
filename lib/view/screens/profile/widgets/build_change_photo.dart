import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants/theme/colors.dart';
import '../../../../features/state/cubit/drawer/drawer_image_cubit.dart';

/// Change photo
Future<void> changePhoto(BuildContext context) async {
  final imagePicker = ImagePicker();
  await showGeneralDialog(
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
            /// Camera
            TextButton.icon(
              onPressed: () async {
                final pickedImage = await imagePicker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 50,
                );

                if (pickedImage == null) {
                  return;
                }

                final imageFile = File(pickedImage.path);

                log(imageFile.path);

                final croppedFile = await ImageCropper().cropImage(
                  sourcePath: imageFile.path,
                  compressFormat: ImageCompressFormat.jpg,
                  compressQuality: 100,
                  uiSettings: [
                    AndroidUiSettings(
                      toolbarTitle: 'Cropper',
                      toolbarColor: MyColors.primary,
                      toolbarWidgetColor: Colors.white,
                      initAspectRatio: CropAspectRatioPreset.original,
                      lockAspectRatio: false,
                    ),
                    IOSUiSettings(
                      title: 'Cropper',
                    ),
                  ],
                );

                final File file = File(croppedFile!.path);

                if (!context.mounted) {
                  throw Exception('Context is not mounted');
                }

                Navigator.of(context).pop();

                /// Change photo
                await context.read<DrawerImageCubit>().changeProfilePhoto(file);

                /// Delete image file
                imageFile.deleteSync();
                file.deleteSync();
              },
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              label: const Text(
                'Camera',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            /// Gallery
            TextButton.icon(
              onPressed: () async {
                final pickedImage = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 50,
                );
                if (pickedImage == null) {
                  return;
                }

                final imageFile = File(pickedImage.path);

                final croppedFile = await ImageCropper().cropImage(
                  sourcePath: imageFile.path,
                  compressFormat: ImageCompressFormat.jpg,
                  compressQuality: 100,
                  uiSettings: [
                    AndroidUiSettings(
                        toolbarTitle: 'Cropper',
                        toolbarColor: MyColors.primary,
                        toolbarWidgetColor: Colors.white,
                        initAspectRatio: CropAspectRatioPreset.original,
                        lockAspectRatio: false),
                    IOSUiSettings(
                      title: 'Cropper',
                    ),
                  ],
                );

                if (croppedFile == null) {
                  return;
                }

                final File file = File(croppedFile.path);

                if (!context.mounted) {
                  throw Exception('Context is not mounted');
                }

                Navigator.of(context).pop();

                /// Change photo
                await context.read<DrawerImageCubit>().changeProfilePhoto(file);

                /// Delete image file
                imageFile.deleteSync();
                file.deleteSync();
              },
              icon: const Icon(
                Icons.photo_library,
                color: Colors.white,
              ),
              label: const Text(
                'Gallery',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
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

  final cacheManager = DefaultCacheManager();
  // await cacheManager.emptyCache();
  // cacheManager.store.emptyMemoryCache();
  log(File(cacheManager.store.toString()).toString());
  log(cacheManager.store.lastCleanupRun.toString());
  log(FirebaseAuth.instance.currentUser.toString());
}
