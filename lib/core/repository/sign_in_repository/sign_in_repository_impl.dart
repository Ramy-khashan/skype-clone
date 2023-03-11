  

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      storage.write(
          key: StorageKeys.userImage, value: value.docs[0].get("image"));
      storage.write(key: StorageKeys.userId, value: value.docs[0].id);
    });
  }

  @override
  Future<Either<String, String>> signInWithGoogle() async {
    try {
      GoogleSignIn signInGoogle = GoogleSignIn(
          clientId:
              "97075547990-vji8mh6ol44vk2pdueonceutgctb0bqp.apps.googleusercontent.com",
          scopes: ["email", "profile"]);
      signInGoogle.signOut();
      GoogleSignInAccount? googleSignInAccount = await signInGoogle.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await setDataFromGoogle(userData: userCredential);
      return right("Enter Successfully");
    } on FirebaseException catch (e) {
      return left(e.toString());
    } catch (e) {
      return left("Faild To Sign In");
    }
  }

  setDataFromGoogle({required UserCredential userData}) async {
    int count = 0;
    await FirebaseFirestore.instance
        .collection(AppString.firestorUsereKey)
        .where("user_uid", isEqualTo: userData.user!.uid)
        .get()
        .then((value) {
      count = value.docs.length;
    });
    if (count == 0) {
      await FirebaseFirestore.instance
          .collection(AppString.firestorUsereKey)
          .add({
        "email": userData.user!.email,
        "phone": userData.user!.phoneNumber ?? "Not Exsist",
        "name": userData.user!.displayName ?? "Name",
        "user_uid": userData.user!.uid,
        "image": userData.user!.photoURL ??
            'https://firebasestorage.googleapis.com/v0/b/have-fun-a5c87.appspot.com/o/userImg.png?alt=media&token=4f962df4-7c2d-4dd2-8950-f64e1ed9863d'
      }).then((value) async { 
        await FirebaseFirestore.instance
            .collection(AppString.firestorUsereKey)
            .doc(value.id)
            .update({"user_id": value.id});
      }).whenComplete(() async {
        await setLocalData(uid: userData.user!.uid);
      });
    } else {
      await setLocalData(uid: userData.user!.uid);
    }
  }
}
