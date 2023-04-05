 
import 'package:flutter/material.dart'; 
import 'package:skype/core/utils/functions/size_config.dart'; 
import 'package:skype/modules/group_media/view/widgets/group_video.dart'; 
import 'widgets/group_image.dart';
import 'widgets/group_pdf.dart';

class GroupMediaScreen extends StatelessWidget {
  final String groupId;
  const GroupMediaScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3 ,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Group Media",
              style: TextStyle(fontSize: getFont(30)),
            ),
            bottom: const TabBar(tabs: [
              Tab(
                text: "Image",
              ),
              Tab(
                text: "Video",
              ),
              Tab(
                text: "PDF",
              )
            ]),
          ),
          body: TabBarView(children: [
            GroupImageItem(groupId: groupId),
            GroupVideoItem(groupId: groupId),
            GroupPdfItem(groupId: groupId),
          ])),
    );
  }
}
