 

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:skype/core/api/dio_consumer.dart';
import 'package:skype/core/api/end_points.dart';
import 'package:skype/core/api/exceptions.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype/core/utils/app_strings.dart';
import 'sign_up_repository.dart';

class SignUpRepositoryImpl extends SignUpRepository {
  DioConsumer dio;
  SignUpRepositoryImpl({required this.dio});
  @override
  Future<Either<ServerException, String>> signUpMethod(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    try { 
      Map response = await dio.post(EndPoints.signUp, body: {
        "email": email,
        "password": password,
        "returnSecureToken": true
      });

      await saveUserInDataBase(
        email: email,
        name: name,
        phone: phone,
        uid: response["localId"],
      );
      return right("Email Create successfully");
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

  Future<void> saveUserInDataBase(
      {required String email,
      required String name,
      required String uid,
      required String phone}) async {
    await FirebaseFirestore.instance
        .collection(AppString.firestorUsereKey)
        .add({
      "email": email,
      "phone": phone,
      "name": name,
      "user_uid": uid,
      "image": 'https://firebasestorage.googleapis.com/v0/b/have-fun-a5c87.appspot.com/o/userImg.png?alt=media&token=4f962df4-7c2d-4dd2-8950-f64e1ed9863d'
    }).then((value) async { 
      await FirebaseFirestore.instance
          .collection(AppString.firestorUsereKey)
          .doc(value.id)
          .update({"user_id": value.id});
    });
  }
}
