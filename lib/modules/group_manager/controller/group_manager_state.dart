part of 'group_manager_cubit.dart';

abstract class GroupManagerState extends Equatable {
  const GroupManagerState();

  @override
  List<Object> get props => [];
}

class GroupManagerInitial extends GroupManagerState {}
class LoadingGroupDataState extends GroupManagerState {}
class GetGroupDataState extends GroupManagerState {}
class FaildGetGroupDataState extends GroupManagerState {}
