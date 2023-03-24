import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skype/config/app_controller/appcontrorller_cubit.dart';
import 'package:skype/core/utils/app_strings.dart';
import 'package:skype/core/utils/functions/app_toast.dart';
import 'package:skype/core/utils/storage_keys.dart';
import 'package:skype/modules/chats/model/user_model.dart';

import 'package:dartz/dartz.dart';

import '../../../modules/chats/cubit/chat_cubit.dart';
import 'search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  @override
  Future<Either<String, List<UserModel>>> getUSuserBySearch() async {
    try {
      String? userId =
          await const FlutterSecureStorage().read(key: StorageKeys.userId);
      List<UserModel> users = [];
      await FirebaseFirestore.instance
          .collection(AppString.firestorUsereKey)
          .where("private", isEqualTo: false)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          for (var element in value.docs) {
            if (element.get("user_id") != userId) {
              users.add(UserModel.fromJson({
                "email": element.get("email"),
                "phone": element.get("phone"),
                "name": element.get("name"),
                "user_id": element.get("user_id"),
                "user_uid": element.get("user_uid"),
                "image": element.get("image"),
              }));
            }
          }
        }
      });
      return right(users);
    } on FirebaseException catch (e) {
      return left(e.message!);
    }
  }

  @override
  Future addFrind({
    required String name,
    required String reciverId,
  }) async {
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
        "message": "Hi, $name",
        "time": DateTime.now(),
        "type": "text"
      },
    ).then((value) {
      FirebaseFirestore.instance
          .collection(AppString.messafeKey)
          .doc(reciverId)
          .collection(userId!)
          .add(
        {
          "sender": userId,
          "reciver": reciverId,
          "message": "Hi, $name",
          "time": DateTime.now(),
          "type": "text"
        },
      );
      appToast("Friend Add Succrssfully");
    });
  }

  @override
  Future addFriendToUser({required String friendId, context}) async {
    String? userid =
        await const FlutterSecureStorage().read(key: StorageKeys.userId);
    FirebaseFirestore.instance
        .collection(AppString.firestorUsereKey)
        .doc(userid)
        .update({
      "users": FieldValue.arrayUnion([friendId])
    });
    FirebaseFirestore.instance
        .collection(AppString.firestorUsereKey)
        .doc(friendId)
        .update({
      "users": FieldValue.arrayUnion([userid])
    });
    ChatCubit.get(context).getFrinds();
  }
}
