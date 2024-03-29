import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../core/repository/user_chat_repository/user_chat_repository_impl.dart';
import '../../../core/utils/app_strings.dart';

part 'user_chat_state.dart';

class UserChatCubit extends Cubit<UserChatState> {
  final UserChatRepositoryImpl userChatRepositoryImpl;
  UserChatCubit({required this.userChatRepositoryImpl})
      : super(UserChatInitial());
  static UserChatCubit get(context) => BlocProvider.of(context);
  late VideoPlayerController videoController;
  bool isdisable = false;
  bool isClickingMsg = false;
  final controllerMsg = TextEditingController();
  sendMsg({required String reciver, token, required String type, msg}) async {
    if (controllerMsg.text.isNotEmpty || msg != null) {
      sendNotification(
          token, "sender", msg == AppString.likeKey ? "Send you like" : msg);
      await userChatRepositoryImpl.sendMessage(
        description: "",
        message:
            controllerMsg.text.trim().isEmpty ? msg : controllerMsg.text.trim(),
        reciverId: reciver,
        msgType: type,
      );
    }
    controllerMsg.clear();
    onText(controllerMsg.text.trim());
  }

  sendMsgVideoOrImageOrPdf(
      {required String reciver,
      required String type,
      required bool isCamera,
      required bool isPdf,
      required bool isVideo,
      context}) async {
    await userChatRepositoryImpl.pickImageOrVideo(
        isCamera: isCamera,
        type: type,
        reciverId: reciver,
        isPdf: isPdf,
        isVideo: isVideo,
        context: context);

    emit(AddedItemMediaState());
  }

  onTap() {
    isShowEmoji = false;
    emit(ChangeEmojiState());
  }

  bool isEmpty = true;
  onText(val) {
    emit(UserChatInitial());

    if (controllerMsg.text.trim().isEmpty) {
      isEmpty = false;
    } else {
      isEmpty = true;
    }
    emit(TextFieldEmptyState());
  }

  bool isShowEmoji = false;
  onSelectEmoji() {
    isShowEmoji = true;

    emit(ChangeEmojiState());
  }

  bool isLoadingVideo = false;
  VideoPlayerController intializeVideo({required String videoUrl}) {
    //  videoVolume=100;
    isLoadingVideo = true;
    // isPlaying = true;
    // isHidePlaying = false;
    emit(LoadingVideoState());
    videoController = VideoPlayerController.network(
      videoUrl,
      videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true, allowBackgroundPlayback: true),
    )..initialize().whenComplete(() {
        isLoadingVideo = false;
        videoController.play();

        emit(InstializeVideoState());
      });
    videoController.addListener(() {
      if (videoController.value.position == videoController.value.duration) {
        // isPlaying = true;
        // isHidePlaying = true;
        emit(PauseVideoState());
      } else if (!videoController.value.isPlaying) {
        // isPlaying = true;
        // isHidePlaying = true;
        emit(VideoEndState());
      } else {
        // isPlaying = true;
        // isHidePlaying = false;

        emit(PLayVideoState());
      }
    });
    return videoController;
  }

  String serverKey =
      'AAAAFponT1Y:APA91bFxHW7HqQcaxNVYxG4F1DuS0tPV2tAQKKLFstjWmETaV7BCwxZqXQQELMeItD_l_iaOYD6Mu8mo85lnaIXvxp2Kh8sOqOtUi90Sxf67nz37mWailn-XZyF88-mqCIUIQxowHliC';

  Future<void> sendNotification(
      String deviceToken, String title, String body) async {
    final payload = {
      'to': deviceToken,
      'notification': {
        'title': title,
        'body': body,
      },
    };

    try {
      final response = await Dio().post("https://fcm.googleapis.com/fcm/send",
          queryParameters: {
            'Content-Type': 'application/json',
            'Authorization':
                'key=Bearer AAAAFponT1Y:APA91bFxHW7HqQcaxNVYxG4F1DuS0tPV2tAQKKLFstjWmETaV7BCwxZqXQQELMeItD_l_iaOYD6Mu8mo85lnaIXvxp2Kh8sOqOtUi90Sxf67nz37mWailn-XZyF88-mqCIUIQxowHliC',
          },
          data: jsonEncode(payload));

      if (response.statusCode == 200) {
        print('Notification sent successfully!');
      } else {
        print(
            'Failed to send notification. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}
