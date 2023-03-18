 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skype/core/utils/app_strings.dart';

import '../../../modules/chats/model/user_model.dart';
import '../../utils/storage_keys.dart';
import 'app_repository.dart';

class AppRepositoryImpl extends AppRepository {
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
        name: name!,
        image: image!,
        phone: phone!,
        email: email!,
        userUid: userUid!,
        userid: userid!);
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
}
