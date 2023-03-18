import 'dart:io';

import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<void> logOut();
  Future<Either<String, File>> getProfileImage();
  Future<Either<String, String>> uploadProfileImage({required File image});
  Future updateFirestor({required Map<String, dynamic> map});
  Future onGetUserSavedData( );
}
