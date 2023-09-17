import 'package:flutter/material.dart';

import '../../../../core/utils/functions/app_toast.dart';
import '../../../../core/utils/functions/size_config.dart';
import '../../../../core/widget/loading_item.dart';

class SignInWithDifferantWayShape extends StatelessWidget {
  final bool isLoading;
  final Function() onPress;
  final String img;
  final String title;
  const SignInWithDifferantWayShape(
      {super.key,
      required this.isLoading,
      required this.onPress,
      required this.img,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
       
      height: getHeight(53),
      child: ElevatedButton(
           style: ElevatedButton.styleFrom( 
            elevation: 9,
           
          padding:  EdgeInsets.symmetric(horizontal: getWidth(10), vertical: getHeight(5))),
        onPressed: isLoading
            ? () {
                appToast("in Process");
              }
            : onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                img,
              ),
            ),
            Text(
              title,
              style:
                  TextStyle(fontSize: getFont(25), fontWeight: FontWeight.w800),
            ),
            Visibility(visible: isLoading, child: const LoadingItem())
          ],
        ),
      ),
    );
  }
}
