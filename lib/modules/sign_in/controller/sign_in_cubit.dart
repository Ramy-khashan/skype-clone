import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype/core/repository/sign_in_repository/sign_in_repository_impl.dart';
import 'package:skype/core/utils/functions/app_toast.dart';

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
    isShowPassword = !isShowPassword;
    emit(ShowPasswordState());
  }

  bool isLoading = false;
  signIn(context) async {
    isLoading = true;
    emit(LoadingSignInState());
    var response = await signInRepositoryImpl.signIn(
        email: emailController.text.trim(),
        password: passwodController.text.trim());
    response.fold((l) {
      appToast(l.toString());
      isLoading = false;
      emit(FaildSignInState());
    }, (r) {
      appToast("success");
      isLoading = false;
      emit(SuccessgSignInState());
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => SignInScreen(),
      //   ),
      //   (route) => false);
    });
  }
}
