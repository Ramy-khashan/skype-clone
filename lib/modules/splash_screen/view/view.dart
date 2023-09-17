import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/app_color.dart';
import '../../../core/utils/functions/size_config.dart';
import '../../../core/utils/storage_keys.dart';
import '../../home/view/home_screen.dart';
import '../../sign_in/view/sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userUid;
  getUser() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();

    userUid = await storage.read(key: StorageKeys.userUid);
  }

  @override
  void initState() {
    getUser();
    Timer(const Duration(milliseconds: 3500), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          if ( userUid==null) {
            return const SignInScreen();
          } else {
            return const HomeScreen();
          }
        },
      ), (route) => false);
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
                  "Pla-La",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getFont(80),
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(
                            blurRadius: 6,
                            color: Colors.white,
                            offset: Offset( .5, .5))
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
