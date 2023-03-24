import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/repository/user_chat_repository/user_chat_repository_impl.dart';

part 'user_chat_state.dart';

class UserChatCubit extends Cubit<UserChatState> {
  final UserChatRepositoryImpl userChatRepositoryImpl;
  UserChatCubit({required this.userChatRepositoryImpl})
      : super(UserChatInitial());
  static UserChatCubit get(context) => BlocProvider.of(context);

  bool isdisable = false;
  bool isClickingMsg = false;
  final controllerMsg = TextEditingController();
  sendMsg({required String reciver, required String type, msg}) async {
    if (controllerMsg.text.isNotEmpty || msg != null) {
      await userChatRepositoryImpl.sendMessage(
        message:
            controllerMsg.text.trim().isEmpty ? msg : controllerMsg.text.trim(),
        reciverId: reciver,
        msgType: type,
      );
    }
    controllerMsg.clear();
    onText(controllerMsg.text.trim());
  }

  sendMsgVideoOrImage(
      {required String reciver,
      required String type,
      required bool isCamera,
      required bool isVideo,
      context}) async {
    await userChatRepositoryImpl.pickImageOrVideo(
        isCamera: isCamera,
        type: type,
        reciverId: reciver,
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
}