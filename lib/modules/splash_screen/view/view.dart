import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skype/core/utils/functions/size_config.dart';
import 'package:skype/core/widget/animation_head.dart';
import 'package:skype/modules/sign_in/view/sign_in.dart';

import '../../../core/utils/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 3500), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [AppColor.primary, AppColor.secondry])),
        child: Center(
          child: TweenAnimationBuilder(
            tween: Tween(
              begin: -pi / 7,
              end: -pi / 360,
            ),
            duration: const Duration(milliseconds: 1500),
            builder: (context, value, child) => Transform.rotate(
              angle: value,
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: AppColor.primary,
                child: Text(
                  "Skype",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getFont(80),
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(
                            blurRadius: 6,
                            color: Colors.white,
                            offset: Offset(3, 3))
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
