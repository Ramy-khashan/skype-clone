import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/repository/sign_in_repository/sign_in_repository_impl.dart';
import '../../../core/services/notification/notification_seervices.dart';
import '../../../core/utils/functions/app_toast.dart';

import '../../home/view/home_screen.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInRepositoryImpl signInRepositoryImpl;
  SignInCubit({required this.signInRepositoryImpl}) : super(SignInInitial());
  static SignInCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwodController = TextEditingController();
  bool isShowPassword = true;
  changeViewPassord() {
    emit(SignInInitial());

    isShowPassword = !isShowPassword;
    emit(ShowPasswordState());
  }

  bool isLoading = false;
  signIn(context) async {
    isLoading = true;
    emit(LoadingSignInState());
    var response = await signInRepositoryImpl.signIn(
        email: emailController.text.trim(),
        password: passwodController.text.trim(),
        token: token!,
        context: context);
    response.fold((l) {
      appToast(l.toString());
      isLoading = false;
      emit(FaildSignInState());
    }, (r) {
      isLoading = false;
      emit(SuccessgSignInState());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    });
  }

  bool isLoadingSignInGoogle = false;
  signInWithGoogle(context) async {
    isLoadingSignInGoogle = true;
    emit(LoadingSignInGoogleState());
    var response = await signInRepositoryImpl.signInWithGoogle(context,token: token!);
    response.fold((l) {
      appToast(l.toString());
      isLoadingSignInGoogle = false;
      emit(FaildSignInGoogleState());
    }, (r) {
      isLoadingSignInGoogle = false;
      emit(SuccessgSignInGoogleState());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    });
  }

  String? token;
  getToken() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      NotificationService().initNotification();
      // FirebaseCrashlytics.instance.crash();
      // FirebaseCrashlyticsPlatform.instance.crash();
      token = await FirebaseMessaging.instance.getToken();
      
      FirebaseMessaging.onMessage.listen((event) {
        
        String? title = event.notification?.title;
        String? body = event.notification?.body;
        NotificationService().showNotification(1, title!, body!, 2);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        
      });
    } catch (e) {}
  }
}
