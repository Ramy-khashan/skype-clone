import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/functions/size_config.dart';

class PdfContainerShape extends StatelessWidget {
  final String title;
  final Function() onPress;
  const PdfContainerShape(
      {super.key, required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).brightness.index == 1
              ? Colors.grey.shade200
              : Colors.black,
          border: Border.all(color: Colors.grey.shade500, width: 1.3),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 1,
                color: Colors.black.withOpacity(.3))
          ]),
      margin: EdgeInsets.only(top: getHeight(8)),
      padding: EdgeInsets.symmetric(
          vertical: getHeight(20), horizontal: getWidth(8)),
      child: InkWell(
        onTap: onPress,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FaIcon(FontAwesomeIcons.download),
            SizedBox(
              width: getWidth(10),
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
