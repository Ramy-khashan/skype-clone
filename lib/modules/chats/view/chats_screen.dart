import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skype/core/utils/app_color.dart';
import 'package:skype/core/utils/functions/size_config.dart';
import 'package:skype/core/widget/loading_item.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_strings.dart';
import '../../user_chat/view/user_chat_screen.dart';
import '../cubit/chat_cubit.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
      final controller = ChatCubit.get(context);
      return controller.isLoadingData
          ? const LoadingItem()
          : controller.userFriendData.isEmpty
              ? Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      "This Quite For Now\nFind New Frinds",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: getFont(30), color: Colors.white),
                    ),
                    SizedBox(
                      height: getHeight(15),
                    ),
                    CircleAvatar(
                      backgroundColor: AppColor.primary,
                      child: IconButton(
                          onPressed: () {
                            controller.getUserdata();
                            controller.getFrinds();
                          },
                          icon: const Icon(Icons.refresh_rounded)),
                    )
                  ]),
                )
              : Scaffold(
                  body: RefreshIndicator(
                      onRefresh: () async {
                        controller.getUserdata();
                        controller.getFrinds();
                      },
                      child: ListView.builder(
                        itemCount: controller.userFriendData.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Card(
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection(AppString.messafeKey)
                                        .doc(controller.userModel!.userid!)
                                        .collection(controller
                                            .userFriendData[index].userid!)
                                        .orderBy("time")
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasData) {
                                        return ListTile(
                                          leading: Hero(
                                            tag: controller
                                                    .userFriendData[index].image
                                                    .toString() +
                                                index.toString(),
                                            child: CircleAvatar(
                                              backgroundColor: AppColor.primary,
                                              foregroundImage: NetworkImage(
                                                  controller
                                                      .userFriendData[index]
                                                      .image!),
                                            ),
                                          ),
                                          title: Text(controller
                                              .userFriendData[index].name!),
                                          subtitle: snapshot.data!.docs.last
                                                  .get("message")
                                                  .toString()
                                                  .isEmpty
                                              ? const Text("You become friends")
                                              : snapshot.data!.docs.last
                                                          .get("type") ==
                                                      "image"
                                                  ? Text(((snapshot
                                                              .data!.docs.last
                                                              .get("sender")) ==
                                                          controller.userModel!
                                                              .userid!
                                                      ? "you : sent image"
                                                      : "${controller.userFriendData[index].name!.split(" ")[0]} sent image")) :snapshot.data!.docs.last
                                                          .get("type") ==
                                                      "video"
                                                  ? Text(((snapshot
                                                              .data!.docs.last
                                                              .get("sender")) ==
                                                          controller.userModel!
                                                              .userid!
                                                      ? "you : sent video"
                                                      : "${controller.userFriendData[index].name!.split(" ")[0]} sent video"))
                                                  : snapshot.data!.docs.last
                                                              .get("message") ==
                                                          AppString.likeKey
                                                      ? Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(((snapshot
                                                                          .data!
                                                                          .docs
                                                                          .last
                                                                          .get(
                                                                              "sender")) ==
                                                                      controller
                                                                          .userModel!
                                                                          .userid!
                                                                  ? "you : "
                                                                  : "")),
                                                              Image.asset(
                                                                AppAssets.like,
                                                                width: getWidth(
                                                                    35),
                                                                height:
                                                                    getHeight(
                                                                        35),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : Text(
                                                          ((snapshot.data!.docs
                                                                          .last
                                                                          .get(
                                                                              "sender")) ==
                                                                      controller
                                                                          .userModel!
                                                                          .userid!
                                                                  ? "you : "
                                                                  : "") +
                                                              snapshot.data!
                                                                  .docs.last
                                                                  .get(
                                                                      "message")
                                                                  .toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserChatScreen(
                                                    tag: controller
                                                            .userFriendData[
                                                                index]
                                                            .image
                                                            .toString() +
                                                        index.toString(),
                                                    friendData: controller
                                                        .userFriendData[index],
                                                    userid: controller
                                                        .userModel!.userid!,
                                                  ),
                                                ));
                                          },
                                          trailing: Text(DateFormat.jm().format(
                                              (snapshot.data!.docs.last
                                                      .get("time") as Timestamp)
                                                  .toDate())),
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }),
                              ),
                              SizedBox(
                                height: index == 14 ? getHeight(80) : 0,
                              )
                            ],
                          );
                        },
                      )));
    });
  }
}
