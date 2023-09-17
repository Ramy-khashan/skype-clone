 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/widget/video_container.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/functions/size_config.dart';
import '../../../../core/widget/loading_item.dart';

class GroupVideoItem extends StatelessWidget {
  final String groupId;
  const GroupVideoItem({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(AppString.firestorGroupKey)
            .doc(groupId)
            .collection(AppString.messafeKey)
            .where("type", isEqualTo: AppString.videoType)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.docs.isEmpty
                ? Center(
                    child: Text(
                      "No Video in group chat",
                      style: TextStyle(
                          fontSize: getFont(30), fontWeight: FontWeight.w500),
                    ),
                  )
                : GridView.count(
                    padding: const EdgeInsets.all(4),
                    crossAxisSpacing: 4,
                    crossAxisCount: 3,
                    children: List.generate(
                        snapshot.data!.docs.length,
                        (index) => GestureDetector(
                              onTap: () {},
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Card(
                                      child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VideoContainerShape(
                                                    videoUrl: snapshot
                                                        .data!.docs[index]
                                                        .get("messages")),
                                          ));
                                    },
                                    leading: const FaIcon(
                                        FontAwesomeIcons.circlePlay),
                                    title: Text(
                                        snapshot.data!.docs[index].get("name") +
                                            " sent this video"),
                                    subtitle: Text(snapshot.data!.docs[index]
                                        .get("description")),
                                  ))),
                            )));
          } else {
            return const LoadingItem();
          }
        });
  }
}
