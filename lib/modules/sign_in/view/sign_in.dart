import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype/core/utils/app_assets.dart';
import 'package:skype/core/utils/app_color.dart';
import 'package:skype/core/utils/functions/app_toast.dart';
import 'package:skype/core/utils/functions/size_config.dart';
import 'package:skype/core/widget/animation_head.dart';
import 'package:skype/core/widget/app_button.dart';
import 'package:skype/core/widget/app_text_field.dart';
import 'package:skype/core/widget/loading_item.dart';
import 'package:skype/modules/sign_up/view/sign_up_screen.dart';

import '../controller/sign_in_cubit.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode focusScopeNode = FocusScope.of(context);
        if (!focusScopeNode.hasPrimaryFocus) {
          return focusScopeNode.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [AppColor.primary, AppColor.secondry])),
            child: SafeArea(
              child: BlocBuilder<SignInCubit, SignInState>(
                builder: (context, state) {
                  final controller = SignInCubit.get(context);
                  return Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const HeadAimation(head: "Sign In"),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: getWidth(10)),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                end: Alignment.topLeft,
                                begin: Alignment.bottomRight,
                                colors: [AppColor.primary, AppColor.secondry]),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  color: Colors.black.withOpacity(.5))
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppTextField(
                                  prefexIcon: const Icon(Icons.email),
                                  onValidate: (val) {
                                    if (val.toString().isEmpty) {
                                      return "This field can't be empty";
                                    }
                                    return null;
                                  },
                                  controller: controller.emailController,
                                  label: "Email Address"),
                              AppTextField(
                                  prefexIcon: const Icon(Icons.password),
                                  onValidate: (val) {
                                    if (val.toString().isEmpty) {
                                      return "This field can't be empty";
                                    }
                                    return null;
                                  },
                                  isPassword: true,
                                  isHidePassword: controller.isShowPassword,
                                  onPressShow: () {
                                    controller.changeViewPassord();
                                  },
                                  controller: controller.passwodController,
                                  label: "Password"),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            controller.isLoading
                                ? const LoadingItem()
                                : AppButton(
                                    head: "Sign In",
                                    headSize: 23,
                                    onPress: () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        controller.signIn(context);
                                      }
                                    }),
                            SizedBox(
                              height: getHeight(15),
                            ),
                            Text.rich(TextSpan(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade900),
                                children: [
                                  const TextSpan(
                                      text: "Do not have an account?  "),
                                  WidgetSpan(
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SignUpScreen()),
                                                (route) => false);
                                          },
                                          child: const Text(
                                            "Sign Up",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white70,
                                            ),
                                          )))
                                ]))
                          ],
                        ),
                        SizedBox(
                          width: getWidth(270),
                          height: getHeight(53),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: controller.isLoadingSignInGoogle
                                ? () {
                                    appToast("in Process");
                                  }
                                : () {
                                    controller.signInWithGoogle(context);
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    AppAssets.google,
                                  ),
                                ),
                                Text(
                                  "Sign With Google",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: getFont(25),
                                      fontWeight: FontWeight.w800),
                                ),
                                Visibility(
                                    visible: controller.isLoadingSignInGoogle,
                                    child: const LoadingItem())
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}
