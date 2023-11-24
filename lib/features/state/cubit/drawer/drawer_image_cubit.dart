import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';

class DrawerImageCubit extends Cubit<String?> {
  DrawerImageCubit() : super(null);

  /// Profile Photo Url

  void profilePhotoUrl() {
    final user = FirebaseAuth.instance.currentUser;
    final imageUrl = user?.photoURL;

    if (imageUrl != null) {
      return emit(imageUrl);
    }
    return emit(null);
  }

  /// Change Profile Photo
  Future<void> changeProfilePhoto(File profilePhoto) async {
    emit(null);
    final user = FirebaseAuth.instance.currentUser;
    final firestore = FirebaseStorage.instance;
    final ref =
        firestore.ref().child('profilePhotos').child('${user!.email!}.jpg');
    await ref.putFile(profilePhoto);
    final url = await ref.getDownloadURL();
    await user.updatePhotoURL(url);

    profilePhotoUrl();
  }
}

/// ImageWidget
ImageProvider imageWidget(String? state) {
  if (state != null) {
    return NetworkImage(
      state.toString(),
    );
  } else {
    return const AssetImage(Assets.imagesProfile);
  }
}
