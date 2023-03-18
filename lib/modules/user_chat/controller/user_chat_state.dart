part of 'user_chat_cubit.dart';

abstract class UserChatState extends Equatable {
  const UserChatState();

  @override
  List<Object> get props => [];
}

class UserChatInitial extends UserChatState {}

class TextFieldEmptyState extends UserChatState {}

class ChangeEmojiState extends UserChatState {}

class AddedItemMediaState extends UserChatState {}
