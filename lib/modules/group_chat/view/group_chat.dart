import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skype/core/utils/app_assets.dart';
import 'package:skype/core/utils/app_strings.dart';
import 'package:skype/core/utils/functions/app_toast.dart';
import 'package:skype/core/utils/functions/group_image_video.dart';
import 'package:skype/modules/group/model/group_model.dart';
import 'package:skype/modules/group_chat/view/widget/group_msg.dart';
import 'package:skype/modules/group_manager/view/group_manager_screen.dart';
import 'package:skype/modules/user_chat/view/widgets/emojis.dart';

import '../../../core/repository/group_chat/group_chat_repository_impl.dart';
import '../../../core/services/server_locator.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/functions/size_config.dart';
import '../controller/group_chat_cubit.dart';

class GroupChatScreen extends StatelessWidget {
  final String tag;
  final GroupModel groupData;
  final String userId;
  const GroupChatScreen(
      {super.key,
      required this.tag,
      required this.groupData,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupChatCubit(
          groupChatRepositoryImpl: sl.get<GroupChatRepositoryImpl>()),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupManagerScreen(
                          groupId: groupData.groupId,
                          userId: userId,
                          groupModel: groupData,
                        ),
                      ));
                },
                icon: const FaIcon(
                  FontAwesomeIcons.circleInfo,
                  color: Colors.white,
                  size: 25,
                )),
          ],
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: tag,
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: getWidth(26),
                  foregroundImage: NetworkImage(groupData.image),
                ),
              ),
              SizedBox(
                width: getWidth(10),
              ),
              Expanded(
                child: Text(
                  groupData.name.split(" ")[0],
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
            GroupMessageItem(
              userId: userId,
              groupId: groupData.groupId,
            ),
            BlocBuilder<GroupChatCubit, GroupChatState>(
              builder: (context, state) {
                final controller = GroupChatCubit.get(context);
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
                                            groupImageVideo(
                                                groupId: groupData.groupId,
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
                                      groupId: groupData.groupId,
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
                                          groupId: groupData.groupId,
                                          type: "text");
                                    },
                                    icon: const Icon(
                                      Icons.send_rounded,
                                      color: Colors.white,
                                    )),
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
