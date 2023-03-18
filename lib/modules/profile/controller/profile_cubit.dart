import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype/core/repository/profile_repository/profile_repository_impl.dart';
import 'package:skype/core/utils/functions/app_toast.dart';

import '../../chats/model/user_model.dart';
import '../../home/view/home_screen.dart';
import '../../splash_screen/view/view.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepositoryImpl profileRepositoryImpl;

  ProfileCubit({required this.profileRepositoryImpl}) : super(ProfileInitial());

  initial() async {
    file = null;

    emit(GetImageState());
  } 

  static ProfileCubit get(context) => BlocProvider.of(context);
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

  saveNewProfileImage(context) async {
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
