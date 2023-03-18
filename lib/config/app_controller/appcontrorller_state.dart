part of 'appcontrorller_cubit.dart';

abstract class AppcontrorllerState extends Equatable {
  const AppcontrorllerState();

  @override
  List<Object> get props => [];
}

class AppcontrorllerInitial extends AppcontrorllerState {}
class GetUserDataState extends AppcontrorllerState {}
class GetUserFrindsState extends AppcontrorllerState {}
class StartGettingFriendDataState extends AppcontrorllerState {}
class GetFriendDataState extends AppcontrorllerState {}
