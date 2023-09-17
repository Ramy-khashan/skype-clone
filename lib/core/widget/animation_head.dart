import 'dart:math';

import 'package:flutter/material.dart';
import '../utils/functions/size_config.dart';

class HeadAimation extends StatelessWidget {
  final String head; 
 
  const HeadAimation({super.key, required this.head  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(
        begin: -pi / 7,
        end: -pi / 360,
      ),
      duration: const Duration(seconds: 2),
      builder: (context, value, child) => Transform.rotate(
        angle: value,
        child:   Text(
          head,
          style:   TextStyle(
              color:Colors.white,
              fontSize: getFont(60),
              fontWeight: FontWeight.bold,
              shadows: const [
                Shadow(color: Colors.black, offset: Offset(7, 5), blurRadius: 5)
              ]),
        ),
      ),
    );
  }
}
