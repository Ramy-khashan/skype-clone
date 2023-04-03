part of 'group_chat_cubit.dart';

abstract class GroupChatState extends Equatable {
  const GroupChatState();

  @override
  List<Object> get props => [];
}

class GroupChatInitial extends GroupChatState {}
class UserChatInitial extends GroupChatState {}

class TextFieldEmptyState extends GroupChatState {}

class ChangeEmojiState extends GroupChatState {}

class AddedItemMediaState extends GroupChatState {}
