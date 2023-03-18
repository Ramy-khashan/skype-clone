import 'package:flutter/material.dart';
import 'package:skype/core/utils/functions/size_config.dart'; 

class AppButton extends StatelessWidget {
  final String head;
  final double headSize;
  final Function() onPress;
  const AppButton(
      {super.key,
      required this.head,
      required this.headSize,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
          padding:  EdgeInsets.symmetric(horizontal: getWidth(20), vertical: getHeight(10))),
      onPressed: onPress,
      child: Text(
        head,
        style: TextStyle(
            color: Colors.black,
            fontSize: headSize,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
