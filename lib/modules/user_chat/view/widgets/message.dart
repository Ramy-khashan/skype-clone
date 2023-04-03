import 'dart:developer';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:skype/core/widget/loading_item.dart';
import 'package:skype/core/widget/pdf_container.dart';
import 'package:skype/core/widget/video_container.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/functions/open_url.dart';
import '../../../../core/utils/functions/size_config.dart';
import '../../controller/user_chat_cubit.dart';
import 'view_image.dart';

class MessageItem extends StatelessWidget {
  final String userid;
  final String reciverid;
  const MessageItem({super.key, required this.userid, required this.reciverid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(AppString.messafeKey)
          .doc(userid)
          .collection(reciverid)
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
                      (index) => messages[index]
                              .get("message")
                              .toString()
                              .isEmpty
                          ? const SizedBox()
                          : Align(
                              alignment:
                                  messages[index].get("reciver") == userid
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                              child: messages[index].get("type") == "text"
                                  ? messages[index].get("message") ==
                                          AppString.likeKey
                                      ? Image.asset(
                                          AppAssets.like,
                                          scale: 10,
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              color: messages[index]
                                                          .get("reciver") ==
                                                      userid
                                                  ? AppColor.secondry
                                                  : AppColor.primary,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          padding: const EdgeInsets.all(12),
                                          margin: EdgeInsets.only(
                                              top: 6,
                                              bottom: 6,
                                              left: messages[index]
                                                          .get("reciver") ==
                                                      userid
                                                  ? 0
                                                  : 120,
                                              right: messages[index]
                                                          .get("reciver") ==
                                                      userid
                                                  ? 120
                                                  : 0),
                                          child: messages[index]
                                                  .get("message")
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
                                                        .get("message")),
                                                    style: TextStyle(
                                                        fontSize: getFont(20),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors
                                                            .blue.shade200,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                )
                                              : SelectableText(
                                                  (messages[index]
                                                      .get("message")),
                                                  style: TextStyle(
                                                      fontSize: getFont(20),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: messages[index].get(
                                                                  "reciver") ==
                                                              userid
                                                          ? Colors.black
                                                          : Colors.white),
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
                                                        .get("message"),
                                                    tag: messages[index]
                                                            .get("message") +
                                                        index.toString(),
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            decoration: BoxDecoration(
                                                color: messages[index]
                                                            .get("reciver") ==
                                                        userid
                                                    ? AppColor.secondry
                                                    : AppColor.primary,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            height: getHeight(200),
                                            margin: EdgeInsets.only(
                                                top: 6,
                                                bottom: 6,
                                                left: messages[index]
                                                            .get("reciver") ==
                                                        userid
                                                    ? 0
                                                    : 120,
                                                right: messages[index]
                                                            .get("reciver") ==
                                                        userid
                                                    ? 120
                                                    : 0),
                                            child: Center(
                                              child: Hero(
                                                tag: messages[index]
                                                        .get("message") +
                                                    index.toString(),
                                                child: CachedNetworkImage(
                                                  imageUrl: messages[index]
                                                      .get("message"),
                                                  fit: BoxFit.fill,
                                                  width: getWidth(300),
                                                  height: getHeight(200),
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      const LinearProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
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
                                              onPress: () {
                                                onOpenUrl(
                                                    url: messages[index]
                                                        .get("message"));
                                              })
                                          : messages[index].get("type") ==
                                                  "video"
                                              ? InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              VideoContainerShape(
                                                                  videoUrl: messages[
                                                                          index]
                                                                      .get(
                                                                          "message")),
                                                        ));
                                                  },
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Card(
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          getWidth(15)),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          const FaIcon(
                                                              FontAwesomeIcons
                                                                  .circlePlay),
                                                          SizedBox(
                                                            width: getWidth(10),
                                                          ),
                                                          const Text(
                                                            "View Video",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
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
