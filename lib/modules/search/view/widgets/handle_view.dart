import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/functions/size_config.dart';

class HandleViewItem extends StatelessWidget {
  final IconData icon;
  final String head;
  const HandleViewItem({super.key, required this.icon, required this.head});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            icon,
           
            size: getWidth(155),
          ),
          SizedBox(
            height: getHeight(22),
          ),
          Text(
            head,
            style: TextStyle(
              fontSize: getFont(30),
           
            ),
          ),
        ],
      ),
    );
  }
}
