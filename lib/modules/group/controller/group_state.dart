part of 'group_cubit.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupInitial extends GroupState {}
class GetUserFrindsState extends GroupState {}
class StartGettingFriendDataState extends GroupState {}
class GetUserDataState extends GroupState {}
class GetFriendDataState extends GroupState {}
class GetUserGroupState extends GroupState {}
class StartLoadingUserGroupState extends GroupState {}
class LoadingCreateGroupState extends GroupState {}
class EndLoadingCreateGroupState extends GroupState {}
