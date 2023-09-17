
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/repository/sign_up_repository/sign_up_repository_impl.dart';
import '../../../core/utils/functions/app_toast.dart';
import '../../sign_in/view/sign_in.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepositoryImpl signUpRepositoryImpl;
  SignUpCubit({required this.signUpRepositoryImpl}) : super(SignUpInitial());
  static SignUpCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final nameControrller = TextEditingController();
  final emailControrller = TextEditingController();
  final phoneControrller = TextEditingController();
  final passwordControrller = TextEditingController();
  bool isShowPassword = true;
  changeViewPassord() {
    emit(SignUpInitial());

    isShowPassword = !isShowPassword;
    emit(ShowPasswordState());
  }

  bool isLoading = false;
  signIn(context) async {
    isLoading = true;
    emit(LoadingSignUpState());

    var res = await signUpRepositoryImpl.signUpMethod(
        email: emailControrller.text.trim(),
        password: passwordControrller.text.trim(),
        name: nameControrller.text.trim(),
        phone: phoneControrller.text.trim());
    res.fold((l) {
      isLoading = false;
      emit(FaildSignUpState());

      appToast(l.message!);
    }, (r) {
      isLoading = false;
      emit(SuccessgSignUpState());
      appToast(r);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ),
          (route) => false);
    });
  }
}
