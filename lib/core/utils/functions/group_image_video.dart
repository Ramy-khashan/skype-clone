import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../modules/group_chat/controller/group_chat_cubit.dart';
import '../app_color.dart';
import 'size_config.dart';

groupImageVideo(
        {required String groupId,
        required BuildContext context,
        required GroupChatCubit controller}) =>
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.primary,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => Padding(
        padding: EdgeInsets.all(getWidth(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              child: ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.cameraRotate,
                ),
                onTap: () {
                  controller.sendMsgVideoOrImageOrPdf(
                      context: context,
                      isCamera: true,
                      isPdf: false,
                      groupId: groupId,
                      type: "image",
                      isVideo: false);
                },
                title: const Text("Get Image From Camera"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.images,
                ),
                onTap: () {
                  controller.sendMsgVideoOrImageOrPdf(
                      context: context,
                      isCamera: false,
                      isPdf: false,
                      groupId: groupId,
                      type: "image",
                      isVideo: false);
                },
                title: const Text("Get Image From Gallory"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.video,
                ),
                onTap: () {
                  controller.sendMsgVideoOrImageOrPdf(
                      context: context,
                      isCamera: false,
                      isPdf: false,
                      groupId: groupId,
                      type: "video",
                      isVideo: true);
                },
                title: const Text("Get Video From Gallory"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.filePdf,
                ),
                onTap: () {
                 controller.sendMsgVideoOrImageOrPdf(
                      context: context,
                      isCamera: false,
                      isPdf: true,

                      groupId: groupId,
                      type: "pdf",
                      isVideo: false);
                },
                title: const Text("Get PDF"),
              ),
            )
          ],
        ),
      ),
    );
