import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/repository/profile_repository/profile_repository_impl.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/functions/app_toast.dart';
import '../../../core/utils/storage_keys.dart';

import '../../home/view/home_screen.dart';
import '../../splash_screen/view/view.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepositoryImpl profileRepositoryImpl;

  ProfileCubit({required this.profileRepositoryImpl}) : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);

  bool isPrivate = true;
  initial() async {
    file = null;
    isPrivate = await const FlutterSecureStorage()
                .read(key: StorageKeys.userPrivateState) ==
            "false"
        ? false
        : true;
    log(isPrivate.toString());
    emit(GetImageState());
  }

  changePrivateState(bool value) async {
    emit(ProfileInitial());

    isPrivate = value;
    String? userId =
        await const FlutterSecureStorage().read(key: StorageKeys.userId);

    await const FlutterSecureStorage()
        .write(key: StorageKeys.userPrivateState, value: value.toString());

    FirebaseFirestore.instance
        .collection(AppString.firestorUsereKey)
        .doc(userId)
        .update({"private": value});
    emit(ChangePrivateState());
  }

  logOut(context) async {
    await profileRepositoryImpl.logOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          ),
          (route) => false);
    });
  }

  File? file;
  getImage() async {
    final response = await profileRepositoryImpl.getProfileImage();
    response.fold((l) {
      return appToast(l);
    }, (r) => file = r);
    emit(GetImageState());
  }
bool isLoadingSave=false;
  saveNewProfileImage(context) async {
    isLoadingSave=true;
    emit(SaveProfileImageState());
    final response =
        await profileRepositoryImpl.uploadProfileImage(image: file!);
    response.fold((l) => appToast(l), (r) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
      return appToast(r);
    });
  }
}
