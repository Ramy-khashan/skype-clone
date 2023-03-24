part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}
class GetUserDataState extends ChatState {}
class GetUserFrindsState extends ChatState {}
class StartGettingFriendDataState extends ChatState {}
class GetFriendDataState extends ChatState {}