import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../app_color.dart';
import 'size_config.dart';

chatImageVideo(
        {required String reciverId,
        required BuildContext context,
        required controller}) =>
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
                  controller.sendMsgVideoOrImage(
                      context: context,
                      isCamera: true,
                      reciver: reciverId,
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
                  controller.sendMsgVideoOrImage(
                      context: context,
                      isCamera: false,
                      reciver: reciverId,
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
                  controller.sendMsgVideoOrImage(
                      context: context,
                      isCamera: false,
                      reciver: reciverId,
                      type: "video",
                      isVideo: true);
                },
                title: const Text("Get Video From Gallory"),
              ),
            )
          ],
        ),
      ),
    );
