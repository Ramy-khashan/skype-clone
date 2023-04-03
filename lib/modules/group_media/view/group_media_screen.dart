import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skype/core/utils/app_strings.dart';
import 'package:skype/core/utils/functions/size_config.dart';
import 'package:skype/core/widget/loading_item.dart';

import '../../user_chat/view/widgets/view_image.dart';

class GroupMediaScreen extends StatelessWidget {
  final String groupId;
  const GroupMediaScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Group Media",
          style: TextStyle(fontSize: getFont(30)),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(AppString.firestorGroupKey)
              .doc(groupId)
              .collection(AppString.messafeKey)
              .where("type", isEqualTo: AppString.imageType)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.docs.isEmpty
                  ? Center(
                      child: Text(
                        "No image in group chat",
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
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewImageItem(
                                          image: snapshot.data!.docs[index]
                                              .get("messages"),
                                          tag: snapshot.data!.docs[index]
                                                  .get("messages") +
                                              index.toString(),
                                        ),
                                      ));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Hero(
                                    tag: snapshot.data!.docs[index]
                                            .get("messages") +
                                        index.toString(),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.docs[index]
                                          .get("messages"),
                                      fit: BoxFit.fill,
                                      width: getWidth(300),
                                      height: getHeight(200),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              const LinearProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              )));
            } else {
              return const LoadingItem();
            }
          }),
    );
  }
}
