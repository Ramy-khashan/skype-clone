part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}
class GetUserDataState extends ProfileState {}
class LoadingUserDataState extends ProfileState {}
class GetImageState extends ProfileState {}
class ChangePrivateState extends ProfileState {}
class SaveProfileImageState extends ProfileState {}
