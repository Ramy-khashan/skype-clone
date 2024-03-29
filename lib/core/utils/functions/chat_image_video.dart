import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../modules/user_chat/controller/user_chat_cubit.dart';
import '../app_color.dart';
import '../app_strings.dart';
import 'size_config.dart';

chatImageVideo(
        {required String reciverId,
        required BuildContext context,
        required UserChatCubit controller}) =>
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
                      reciver: reciverId,
                      type: AppString.imageType,
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

                      reciver: reciverId,
                      type: AppString.imageType,
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
                      isPdf: false,

                      isCamera: false,
                      reciver: reciverId,
                      type: AppString.videoType,
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
                      isPdf: true,

                      isCamera: false,
                      reciver: reciverId,
                      type: AppString.pdfType,
                      isVideo: true);
                },
                title: const Text("Get PDF"),
              ),
            )
          ],
        ),
      ),
    );
