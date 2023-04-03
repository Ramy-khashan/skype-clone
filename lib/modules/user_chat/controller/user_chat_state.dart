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
class PLayVideoState extends UserChatState {}
class VideoEndState extends UserChatState {}
class PauseVideoState extends UserChatState {}
class InstializeVideoState extends UserChatState {}
class LoadingVideoState extends UserChatState {}
