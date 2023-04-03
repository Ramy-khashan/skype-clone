 import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/repository/group_chat/group_chat_repository_impl.dart';
 
part 'group_chat_state.dart';

class GroupChatCubit extends Cubit<GroupChatState> {
  final GroupChatRepositoryImpl groupChatRepositoryImpl;

  GroupChatCubit({required this.groupChatRepositoryImpl})
      : super(GroupChatInitial());

  static GroupChatCubit get(context) => BlocProvider.of(context);

  bool isdisable = false;
  bool isClickingMsg = false;
  final controllerMsg = TextEditingController();
  sendMsg({required String groupId, required String type, msg}) async {
    if (controllerMsg.text.isNotEmpty || msg != null) {
      await groupChatRepositoryImpl.sendMessage(
        message:
            controllerMsg.text.trim().isEmpty ? msg : controllerMsg.text.trim(),
        groupId: groupId,
        msgType: type, description: '',
      );
    }
    controllerMsg.clear();
    onText(controllerMsg.text.trim());
  }

  sendMsgVideoOrImageOrPdf(
      {required String groupId,
      required String type,
      required bool isCamera,
      required bool isPdf,
      required bool isVideo,
      context}) async {
    await groupChatRepositoryImpl.pickImageOrVideo(
        isCamera: isCamera,
        type: type,
        isPdf: isPdf,
        groupId: groupId,
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
