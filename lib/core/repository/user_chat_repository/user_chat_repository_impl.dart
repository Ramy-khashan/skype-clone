import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skype/core/repository/user_chat_repository/user_chat_repository.dart';
import 'package:skype/core/utils/app_strings.dart';
import 'package:skype/core/utils/functions/pick_image.dart';
import 'package:skype/core/utils/functions/pick_video.dart';
import 'package:skype/core/utils/functions/uplaod_img_video_firebase.dart';
import 'package:skype/core/utils/storage_keys.dart';

class UserChatRepositoryImpl extends UserChatRepository {
  @override
  Future sendMessage(
      {required String message,
      required String reciverId,
      required String msgType}) async {
    String? userId =
        await const FlutterSecureStorage().read(key: StorageKeys.userId);
    FirebaseFirestore.instance
        .collection(AppString.messafeKey)
        .doc(userId)
        .collection(reciverId)
        .add(
      {
        "sender": userId,
        "reciver": reciverId,
        "message": message,
        "time": DateTime.now(),
        "type": msgType
      },
    );
    FirebaseFirestore.instance
        .collection(AppString.messafeKey)
        .doc(reciverId)
        .collection(userId!)
        .add(
      {
        "sender": userId,
        "reciver": reciverId,
        "message": message,
        "time": DateTime.now(),
        "type": msgType
      },
    );
  }

  @override
  Future pickImageOrVideo(
      {required bool isCamera,
      required bool isVideo,
      required String type,
      required context,
      required String reciverId}) async {
    try {
      File file = isVideo
          ? await getVideoPicker()
          : await getImagePicker(isCamera: isCamera);
      log(file.path.toString());
        Navigator.pop(context);
      String itemUrl =
          await uploadImageVideoFirebase(itemFile: file, folder: "caht");
      await sendMessage(message: itemUrl, reciverId: reciverId, msgType: type);
    } on FirebaseException catch (e) {
      log(e.message!);
    } catch (e) {
      log("Failed To Get Image $e");
    }
  }
}
