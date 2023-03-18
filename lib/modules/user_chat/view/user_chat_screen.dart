import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skype/core/utils/app_assets.dart';
import 'package:skype/core/utils/app_strings.dart';
import 'package:skype/core/utils/functions/app_toast.dart';
import 'package:skype/core/utils/functions/chat_image_video.dart';
import 'package:skype/modules/chats/model/user_model.dart';
import 'package:skype/modules/user_chat/view/widgets/emojis.dart';
import 'package:skype/modules/user_chat/view/widgets/message.dart';

import '../../../core/repository/user_chat_repository/user_chat_repository_impl.dart';
import '../../../core/services/server_locator.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/functions/size_config.dart';
import '../controller/user_chat_cubit.dart';

class UserChatScreen extends StatelessWidget {
  final String tag;
  final UserModel friendData;
  final String userid;
  const UserChatScreen(
      {super.key,
      required this.tag,
      required this.friendData,
      required this.userid});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserChatCubit(
          userChatRepositoryImpl: sl.get<UserChatRepositoryImpl>()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [AppColor.primary, AppColor.secondry])),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  appToast('Coming soon!');
                },
                icon: const FaIcon(
                  FontAwesomeIcons.video,
                  size: 25,
                )),
            IconButton(
                onPressed: () {
                  appToast('Coming soon!');
                },
                icon: const FaIcon(
                  FontAwesomeIcons.phone,
                  size: 25,
                ))
          ],
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: tag,
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: getWidth(26),
                  foregroundImage: NetworkImage(friendData.image!),
                ),
              ),
              SizedBox(
                width: getWidth(10),
              ),
              Expanded(
                child: Text(
                  friendData.name!.split(" ")[0],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: getFont(32),
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            MessageItem(userid: userid, reciverid: friendData.userid!),
            BlocBuilder<UserChatCubit, UserChatState>(
              builder: (context, state) {
                final controller = UserChatCubit.get(context);
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            controller: controller.controllerMsg,
                            onChanged: (val) {
                              controller.onText(val);
                            },
                            onTap: () {
                              controller.onTap();
                            },
                            decoration: InputDecoration(
                              suffixIcon:
                                  controller.controllerMsg.text.trim().isEmpty
                                      ? IconButton(
                                          onPressed: () {
                                            chatImageVideo(
                                                reciverId: friendData.userid!,
                                                context: context,
                                                controller: controller);
                                          },
                                          icon: const Icon(
                                            Icons.perm_media_rounded,
                                            color: AppColor.secondry,
                                          ),
                                        )
                                      : null,
                              prefixIcon: IconButton(
                                onPressed: () {
                                  if (controller.isShowEmoji) {
                                    controller.onTap();
                                  } else {
                                    controller.onSelectEmoji();
                                    FocusScopeNode focusScopeNode =
                                        FocusScope.of(context);
                                    if (!focusScopeNode.hasPrimaryFocus) {
                                      return focusScopeNode.unfocus();
                                    }
                                  }
                                },
                                icon: Icon(
                                  controller.isShowEmoji
                                      ? Icons.keyboard
                                      : Icons.emoji_emotions,
                                  color: AppColor.secondry,
                                  size: getWidth(28),
                                ),
                              ),
                              hintText: "Send message",
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppColor.primary),
                                  borderRadius: BorderRadius.circular(15)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppColor.primary),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppColor.primary),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                        )),
                        controller.controllerMsg.text.trim().isEmpty
                            ? GestureDetector(
                                onTap: () {
                                  controller.sendMsg(
                                      msg: AppString.likeKey,
                                      reciver: friendData.userid!,
                                      type: "text");
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(getWidth(2)),
                                  child: Image.asset(
                                    AppAssets.like,
                                    scale: 14,
                                  ),
                                ))
                            : Container(
                                width: getWidth(60),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.secondry),
                                child: IconButton(
                                    onPressed: () {
                                      controller.sendMsg(
                                          reciver: friendData.userid!,
                                          type: "text");
                                    },
                                    icon: const Icon(Icons.send_rounded)),
                              ),
                      ],
                    ),
                    EmojisScreen(
                      onChange: () {
                        controller.onText("val");
                      },
                      messageController: controller.controllerMsg,
                      isEmoji: controller.isShowEmoji,
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
