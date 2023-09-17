 
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
 import 'package:regexpattern/regexpattern.dart';
import '../../../../core/widget/loading_item.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/functions/open_url.dart';
import '../../../../core/utils/functions/size_config.dart';
import '../../../../core/widget/pdf_container.dart';
import '../../../user_chat/view/widgets/view_image.dart';

class GroupMessageItem extends StatelessWidget {
  final String groupId;
  final String userId;
  const GroupMessageItem(
      {super.key, required this.groupId, required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(AppString.firestorGroupKey)
          .doc(groupId)
          .collection(AppString.messafeKey)
          .orderBy("time")
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something Went wrong, Try again later"),
          );
        } else if (snapshot.hasData) {
          List<QueryDocumentSnapshot> messages = snapshot.data!.docs;
          return Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(getWidth(5)),
                reverse: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      messages.length,
                      (index) => messages[index].get("messages").toString().isEmpty?const SizedBox():Align(
                            alignment: messages[index].get("sender") == userId
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: messages[index].get("type") == "text"
                                ? messages[index].get("messages") ==
                                        AppString.likeKey
                                    ? Image.asset(
                                        AppAssets.like,
                                        scale: 10,
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color:
                                                messages[index].get("sender") ==
                                                        userId
                                                    ? AppColor.primary
                                                    : AppColor.secondry,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        padding: const EdgeInsets.all(12),
                                        margin: EdgeInsets.only(
                                            top: 6,
                                            bottom: 6,
                                            left:
                                                messages[index].get("sender") ==
                                                        userId
                                                    ? 120
                                                    : 0,
                                            right:
                                                messages[index].get("sender") ==
                                                        userId
                                                    ? 0
                                                    : 120),
                                        child: messages[index]
                                                .get("messages")
                                                .toString()
                                                .isUrl()
                                            ? GestureDetector(
                                                onTap: () {
                                                  onOpenUrl(
                                                      url: messages[index]
                                                          .get("message"));
                                                },
                                                child: Text(
                                                  (messages[index]
                                                      .get("messages")),
                                                  style: TextStyle(
                                                      fontSize: getFont(20),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          Colors.blue.shade200,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              )
                                            : SelectableText(
                                                (messages[index]
                                                    .get("messages")),
                                                style: TextStyle(
                                                    fontSize: getFont(20),
                                                    fontWeight: FontWeight.w500,
                                                    color: messages[index].get(
                                                                "sender") ==
                                                            userId
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                      )
                                : messages[index].get("type") == "image"
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewImageItem(
                                                  image: messages[index]
                                                      .get("messages"),
                                                  tag: messages[index]
                                                          .get("messages") +
                                                      index.toString(),
                                                ),
                                              ));
                                        },
                                        child: Container(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          decoration: BoxDecoration(
                                              color: messages[index]
                                                          .get("sender") ==
                                                      userId
                                                  ? AppColor.primary
                                                  : AppColor.secondry,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          height: getHeight(200),
                                          margin: EdgeInsets.only(
                                              top: 6,
                                              bottom: 6,
                                              left: messages[index]
                                                          .get("sender") ==
                                                      userId
                                                  ? 120
                                                  : 0,
                                              right: messages[index]
                                                          .get("sender") ==
                                                      userId
                                                  ? 0
                                                  : 120),
                                          child: Center(
                                            child: Hero(
                                              tag: messages[index]
                                                      .get("messages") +
                                                  index.toString(),
                                              child: CachedNetworkImage(
                                                imageUrl: messages[index]
                                                    .get("messages"),
                                                fit: BoxFit.fill,
                                                width: getWidth(300),
                                                height: getHeight(200),
                                                progressIndicatorBuilder: (context,
                                                        url,
                                                        downloadProgress) =>
                                                    const LinearProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : messages[index].get("type") == "pdf"
                                        ? PdfContainerShape(
                                            title: messages[index]
                                                .get("description"),
                                            onPress: () {})
                                        : const SizedBox.shrink(),
                          )),
                ),
              ),
            ),
          );
        } else {
          return const Expanded(child: LoadingItem());
        }
      },
    );
  }
}
