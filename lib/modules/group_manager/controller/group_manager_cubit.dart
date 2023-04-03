import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skype/core/utils/functions/app_toast.dart';
import 'package:skype/core/utils/storage_keys.dart';
import 'package:skype/modules/home/view/home_screen.dart';

import '../../../core/utils/app_strings.dart';
import '../model/user_mode.dart';

part 'group_manager_state.dart';

class GroupManagerCubit extends Cubit<GroupManagerState> {
  GroupManagerCubit() : super(GroupManagerInitial());
  static GroupManagerCubit get(context) => BlocProvider.of(context);

  setAdmin({required String userId, required String groupId}) async {
    await FirebaseFirestore.instance
        .collection(AppString.firestorGroupKey)
        .doc(groupId)
        .update({
      "admin": FieldValue.arrayUnion([userId])
    });
  }

  deleteUser(
      {required String userId,
      required String groupId,
      required context}) async {
    String? userIdValue =
        await const FlutterSecureStorage().read(key: StorageKeys.userId);
    await FirebaseFirestore.instance
        .collection(AppString.firestorGroupKey)
        .doc(groupId)
        .update({
      "admin": FieldValue.arrayRemove([userId])
    }); await FirebaseFirestore.instance
        .collection(AppString.firestorGroupKey)
        .doc(groupId)
        .update({
      "members": FieldValue.arrayRemove([userId])
    });
    if (userId == userIdValue) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    }
  }
}
