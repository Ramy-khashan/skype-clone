
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../modules/group/model/group_model.dart';

import '../../../modules/chats/model/user_model.dart';
import '../../utils/app_strings.dart';
import '../../utils/storage_keys.dart';
import 'group_repository.dart';

class GroupRepositoryImpl extends GroupRepository {
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
  Future getGroup() async {
    String? userId =
        await const FlutterSecureStorage().read(key: StorageKeys.userId);

    List<GroupModel> groups = [];
    await FirebaseFirestore.instance
        .collection(AppString.firestorGroupKey)
        .where("members", arrayContains: userId)
        .get()
        .then((value) { 
      for (var element in List.from(value.docs)) {
        groups.add(GroupModel(
            name: element["name"],
            groupId: element["group_id"],
            image: element["image"],
            member: element["members"],
            admin: element["admin"]));
      }
    });
    return groups;
  }

  @override
  Future getFrindsIds() async {
    String? userId =
        await const FlutterSecureStorage().read(key: StorageKeys.userId);

    List<String> friendsUser = [];
    await FirebaseFirestore.instance
        .collection(AppString.firestorUsereKey)
        .doc(userId)
        .get()
        .then((value) {
      friendsUser = List.from(value.get("users"));
    });
    return friendsUser;
  }

  @override
  Future getFrindsData({required List friendsId}) async {
    List<UserModel> frindsData = [];
    for (var element in friendsId) {
      await FirebaseFirestore.instance
          .collection(AppString.firestorUsereKey)
          .doc(element)
          .get()
          .then(
        (value) {
          frindsData.add(
            UserModel.fromJson(value.data()!),
          );
        },
      );
    }
    return frindsData;
  }

  @override
  Future createGroup({required String name, required String image,required List groupMember}) async {
    String? userName =
        await const FlutterSecureStorage().read(key: StorageKeys.userName);
    String? userId = await const FlutterSecureStorage().read(key: StorageKeys.userId);
   await FirebaseFirestore.instance.collection(AppString.firestorGroupKey).add({
      "name": name,
      "image": image,
      "createBy": userName,
      "members": groupMember,
      "admin": [userId]
    }).then((value) async {
    await  FirebaseFirestore.instance
          .collection(AppString.firestorGroupKey)
          .doc(value.id)
          .update({"group_id": value.id});
      await FirebaseFirestore.instance
          .collection(AppString.firestorGroupKey)
          .doc(value.id)
          .collection(AppString.messafeKey)
          .add({
        AppString.messafeKey: "",
        "description":"",
        "name": userName,
        "sender": userId,
        "type": "text",
        "time": DateTime.now()
      });
    }); 
  }
}
