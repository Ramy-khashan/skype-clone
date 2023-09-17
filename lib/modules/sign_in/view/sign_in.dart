import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_color.dart'; 
import '../../../core/utils/functions/size_config.dart';
import '../../../core/widget/animation_head.dart';
import '../../../core/widget/app_button.dart';
import '../../../core/widget/app_text_field.dart';
import '../../../core/widget/loading_item.dart';
import 'widgets/sign_with_diff_way_shape.dart';
import '../../sign_up/view/sign_up_screen.dart';

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
                                  prefexIcon: const Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  onValidate: (val) {
                                    if (val.toString().isEmpty) {
                                      return "This field can't be empty";
                                    }
                                    return null;
                                  },
                                  controller: controller.emailController,
                                  label: "Email Address"),
                              AppTextField(
                                  prefexIcon: const Icon(
                                    Icons.password,
                                    color: Colors.white,
                                  ),
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
                        Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: getWidth(40)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                ),   SignInWithDifferantWayShape(
                                isLoading: controller.isLoadingSignInGoogle,
                                onPress: () {
                                  controller.signInWithGoogle(context);
                                },
                                img: AppAssets.google,
                                title: "Sign With Google"),   SizedBox(
                                  height: getHeight(15),
                                ),
                                Center(
                                  child: Text.rich(TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade900),
                                      children: [
                                          TextSpan(
                                            text: "Do not have an account?  ",   style: TextStyle(fontSize: getFont(20),)),
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
                                                child:   Text(
                                                  "Sign Up",
                                                  style: TextStyle(fontSize: getFont(20),
                                                    fontWeight: FontWeight.w900,decoration: TextDecoration.underline,
                                                    color: Colors.white60,
                                                  ),
                                                )))
                                      ])),
                                )
                              ],
                            )),
                        // Column(
                        //   children: [
                          
                        //     // SizedBox(
                        //     //   height: getHeight(15),
                        //     // ),
                        //     // SignInWithDifferantWayShape(
                        //     //     isLoading:  false,
                        //     //     onPress: () async {
                        //     //       await FacebookAuth.instance.login(
                        //     //           permissions: [
                        //     //             "Advanced Access",
                        //     //             "email"
                        //     //           ]).then((value) async {
                        //     //           print(value);
                        //     //         // await FacebookAuth.instance
                        //     //         //     .getUserData()
                        //     //         //     .then((userData) async {
                        //     //         //   print(userData);
                        //     //         // });
                        //     //       });
                        //     //     },
                        //     //     img: AppAssets.fb,
                        //     //     title: "Sign With Facebook")
                        
                        //   ],
                        // )
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
