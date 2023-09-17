import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'group_chat_repository.dart';
import '../../utils/functions/pick_pdf.dart';

import '../../utils/app_strings.dart';
import '../../utils/functions/pick_image.dart';
import '../../utils/functions/pick_video.dart';
import '../../utils/functions/uplaod_img_video_firebase.dart';
import '../../utils/storage_keys.dart';

class GroupChatRepositoryImpl extends GroupChatRepository {
  @override
  Future sendMessage(
      {required String message,
      required String groupId,
      required String description,
      required String msgType}) async {
    String? userId =
        await const FlutterSecureStorage().read(key: StorageKeys.userId);
    FirebaseFirestore.instance
        .collection(AppString.firestorGroupKey)
        .doc(groupId)
        .collection(AppString.messafeKey)
        .add(
      {
        "sender": userId,
        "messages": message,
        "description": description,
        "time": DateTime.now(),
        "type": msgType
      },
    );
  }

  @override
  Future pickImageOrVideo({
    required bool isCamera,
    required bool isVideo,
    required bool isPdf,
    required String type,
    required String groupId,
    required context,
  }) async {
    try {
      File file = isPdf
          ?await pickPdf()
          : isVideo
              ? await getVideoPicker()
              : await getImagePicker(isCamera: isCamera);
      log(file.path.toString());
      Navigator.pop(context);
      String itemUrl =
          await uploadImageVideoFirebase(itemFile: file, folder: "caht");
      await sendMessage(message: itemUrl, groupId: groupId, msgType: type,description: path.basename(file.path));
    } on FirebaseException catch (e) {
      log(e.message!);
    } catch (e) {
      log("Failed To Get Image $e");
    }
  }
}
