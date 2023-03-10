import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skype/core/api/dio_consumer.dart';
import 'package:skype/core/api/end_points.dart';
import 'package:skype/core/api/exceptions.dart';

import 'package:dartz/dartz.dart';
import 'package:skype/core/utils/app_strings.dart';
import 'package:skype/core/utils/storage_keys.dart';

import 'sign_in_repository.dart';

class SignInRepositoryImpl extends SignInRepository {
  final DioConsumer dio;

  SignInRepositoryImpl({required this.dio});
  @override
  Future<Either<ServerException, String>> forgetPassword() {
    // TODO: implement forgetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerException, String>> signIn(
      {required String email, required String password}) async {
    try {
      var res = await dio.post(EndPoints.signIn, body: {
        "email": email,
        "password": password,
        "returnSecureToken": true
      });
      await setLocalData(uid: res["localId"]);
      return right("");
    } catch (e) {
      if (e is DioError) {
        return left(dio.handleDioError(e));
      } else if (e is FirebaseException) {
        return left(ServerException(e.message.toString()));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }

  setLocalData({required String uid}) async {
    var storage = const FlutterSecureStorage();
    await FirebaseFirestore.instance
        .collection(AppString.firestorUsereKey)
        .where("user_uid", isEqualTo: uid)
        .get()
        .then((value) {
      storage.write(
          key: StorageKeys.userEmail, value: value.docs[0].get("email"));
      storage.write(
          key: StorageKeys.userName, value: value.docs[0].get("name"));
      storage.write(
          key: StorageKeys.userPhone, value: value.docs[0].get("phone"));
      storage.write(
          key: StorageKeys.userUid, value: value.docs[0].get("user_uid"));
      storage.write(key: StorageKeys.userId, value: value.docs[0].id);
    });
  }
}
