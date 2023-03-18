import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skype/config/app_controller/appcontrorller_cubit.dart';
import 'package:skype/core/utils/app_color.dart';
import 'package:skype/core/utils/functions/size_config.dart';
import 'package:skype/core/widget/loading_item.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_strings.dart';
import '../../user_chat/view/user_chat_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppcontrorllerCubit, AppcontrorllerState>(
        builder: (context, state) {
      final appController = AppcontrorllerCubit.get(context);
      return RefreshIndicator(
        onRefresh: () async {
          appController.getFrinds();
        },
        child: appController.isLoaingFrindData
            ? const LoadingItem()
            : appController.userFriendData.isEmpty
                ? Center(
                    child: Text(
                      "This Quite For Now\nFind New Frinds",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: getFont(30), color: Colors.white),
                    ),
                  )
                : Scaffold(
                    body: RefreshIndicator(
                        onRefresh: () async {
                          appController.getFrinds();
                        },
                        child: ListView.builder(
                          itemCount: appController.userFriendData.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Card(
                                  color: Colors.grey.shade300,
                                  child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection(AppString.messafeKey)
                                          .doc(appController.userModel!.userid!)
                                          .collection(appController
                                              .userFriendData[index].userid!)
                                          .orderBy("time")
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          return ListTile(
                                            leading: Hero(
                                              tag: appController
                                                      .userFriendData[index]
                                                      .image
                                                      .toString() +
                                                  index.toString(),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    AppColor.primary,
                                                foregroundImage: NetworkImage(
                                                    appController
                                                        .userFriendData[index]
                                                        .image!),
                                              ),
                                            ),
                                            title: Text(appController
                                                .userFriendData[index].name!),
                                            subtitle: snapshot.data!.docs.last
                                                        .get("type") ==
                                                    "image"
                                                ? Text(((snapshot
                                                            .data!.docs.last
                                                            .get("sender")) ==
                                                        appController
                                                            .userModel!.userid!
                                                    ? "you : sent image"
                                                    : "${appController.userFriendData[index].name!.split(" ")[0]} sent image"))
                                                : snapshot.data!.docs.last
                                                            .get("message") ==
                                                        AppString.likeKey
                                                    ? Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(((snapshot
                                                                        .data!
                                                                        .docs
                                                                        .last
                                                                        .get(
                                                                            "sender")) ==
                                                                    appController
                                                                        .userModel!
                                                                        .userid!
                                                                ? "you : "
                                                                : "")),
                                                            Image.asset(
                                                              AppAssets.like,
                                                              width:
                                                                  getWidth(35),
                                                              height:
                                                                  getHeight(35),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Text(
                                                        ((snapshot.data!.docs
                                                                        .last
                                                                        .get(
                                                                            "sender")) ==
                                                                    appController
                                                                        .userModel!
                                                                        .userid!
                                                                ? "you : "
                                                                : "") +
                                                            snapshot
                                                                .data!.docs.last
                                                                .get("message")
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
                                                      tag: appController
                                                              .userFriendData[
                                                                  index]
                                                              .image
                                                              .toString() +
                                                          index.toString(),
                                                      friendData: appController
                                                              .userFriendData[
                                                          index],
                                                      userid: appController
                                                          .userModel!.userid!,
                                                    ),
                                                  ));
                                            },
                                            trailing: Text(DateFormat.jm()
                                                .format((snapshot
                                                            .data!.docs.last
                                                            .get("time")
                                                        as Timestamp)
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
                        ))),
      );
    });
  }
}
