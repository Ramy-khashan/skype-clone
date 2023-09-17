import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../utils/app_strings.dart';
import '../../utils/functions/uplaod_img_video_firebase.dart';
import '../../utils/storage_keys.dart';

import '../../../modules/chats/model/user_model.dart';
import '../../utils/functions/pick_image.dart';
import 'profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await const FlutterSecureStorage().deleteAll();
  }

  @override
  Future onGetUserSavedData() async {
    const storage = FlutterSecureStorage();
    String? name = await storage.read(key: StorageKeys.userName);
    String? phone = await storage.read(key: StorageKeys.userPhone);
    String? email = await storage.read(key: StorageKeys.userEmail);
    String? userid = await storage.read(key: StorageKeys.userId);
    String? userUid = await storage.read(key: StorageKeys.userUid);
    String? image = await storage.read(key: StorageKeys.userImage);

    return UserModel(
      token: "",
        name: name!,
        image: image!,
        phone: phone!,
        email: email!,
        userUid: userUid!,
        userid: userid!);
  }

  @override
  Future<Either<String, File>> getProfileImage() async {
    try {
      File file = await getImagePicker(isCamera: false);
      return right(file);
    } catch (e) {
      return left("Failed to get image");
    }
  }

  @override
  Future<Either<String, String>> uploadProfileImage(
      {required File image}) async {
    try {
      String imageUrl =
          await uploadImageVideoFirebase(itemFile: image, folder: "profile");
      log(imageUrl);
      await updateFirestor(map: {"image": imageUrl});
      await const FlutterSecureStorage()
          .write(key: StorageKeys.userImage, value: imageUrl);
      return right("Successfully");
    } catch (e) {
      return left("Failed to upload image");
    }
  }

  @override
  updateFirestor({
    required Map<String, dynamic> map,
  }) async {
    String? userId =
        await const FlutterSecureStorage().read(key: StorageKeys.userId);
    await FirebaseFirestore.instance
        .collection(AppString.firestorUsereKey)
        .doc(userId)
        .update(map);
  }
}
