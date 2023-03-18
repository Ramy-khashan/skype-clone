import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype/core/utils/app_color.dart';
import 'package:skype/core/utils/functions/size_config.dart';
import 'package:skype/core/widget/animation_head.dart';
import 'package:skype/core/widget/app_button.dart';
import 'package:skype/core/widget/app_text_field.dart';
import 'package:skype/modules/sign_in/view/sign_in.dart';
import 'package:skype/modules/sign_up/controller/sign_up_cubit.dart';

import '../../../core/widget/loading_item.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              child: BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  final controller = SignUpCubit.get(context);
                  return Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const HeadAimation(head: "Sign Up"),
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
                                  prefexIcon: const Icon(Icons.person),
                                  onValidate: (val) {
                                     if(val.toString().isEmpty){
                                      return"This field can't be empty";
                                    }
                                    return null;
                                  },
                                  controller: controller.nameControrller,
                                  label: "Name"),
                              AppTextField(
                                  prefexIcon: const Icon(Icons.email),
                                  onValidate: (val) {
                                     if(val.toString().isEmpty){
                                      return"This field can't be empty";
                                    }
                                    return null;
                                  },
                                  controller: controller.emailControrller,
                                  label: "Email Address"),
                              AppTextField(
                                  prefexIcon: const Icon(Icons.phone),
                                  onValidate: (val) {
                                     if(val.toString().isEmpty){
                                      return"This field can't be empty";
                                    }
                                    return null;
                                  },
                                  controller: controller.phoneControrller,
                                  label: "Phone Number"),
                              AppTextField(
                                  prefexIcon: const Icon(Icons.password),
                                  onValidate: (val) {
                                     if(val.toString().isEmpty){
                                      return"This field can't be empty";
                                    }
                                    return null;
                                  },
                                  isPassword: true,
                                  isHidePassword: controller.isShowPassword,
                                  onPressShow: () {
                                    controller.changeViewPassord();
                                  },
                                  controller: controller.passwordControrller,
                                  label: "Password"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getWidth(40)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              
                              controller.isLoading
                                  ? const LoadingItem()
                                  : AppButton(
                                      head: "Sign Up",
                                      headSize: getFont(23),
                                      onPress: () {
                                        if (controller.formKey.currentState!
                                            .validate()) {
                                          controller.signIn(context);
                                        }
                                      }),
                              const SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: Text.rich(TextSpan(
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade900),
                                    children: [
                                      const TextSpan(
                                          text: "Already have an account?  "),
                                      WidgetSpan(
                                          child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const SignInScreen()),
                                                    (route) => false);
                                              },
                                              child: const Text(
                                                "Sign In",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white70,
                                                ),
                                              )))
                                    ])),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getHeight(10),
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
