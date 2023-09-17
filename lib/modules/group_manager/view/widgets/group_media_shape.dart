import 'package:flutter/material.dart'; 
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/functions/size_config.dart';
import '../../../group_media/view/group_media_screen.dart';

class GroupMediaShape extends StatelessWidget {
  final String groupId;
  const GroupMediaShape({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getHeight(15)),
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.primary),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: FaIcon(
          FontAwesomeIcons.images,
          color: Theme.of(context).brightness.index == 1
              ? Colors.black
              : Colors.white,
        ),
        title: const Text("Group Media"),
        trailing: FaIcon(
          Icons.arrow_forward_ios_rounded,
          color: Theme.of(context).brightness.index == 1
              ? Colors.black
              : Colors.white,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroupMediaScreen(groupId: groupId),
              ));
        },
      ),
    );
  }
}
