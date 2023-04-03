import 'package:flutter/material.dart';
import 'package:skype/core/utils/app_color.dart';
import 'package:skype/core/utils/functions/size_config.dart';
 

class BottomSheetHead extends StatelessWidget { 
  final String head;
  const BottomSheetHead({Key? key,   required this.head}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width:getWidth(100),
          height: getHeight(10),
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
        ),
        SizedBox(
          height: getHeight(35),
          child: Center(
            child: Text(
              head,
              style: TextStyle(
                  color: AppColor.primary,
                  fontSize:getFont(25),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
