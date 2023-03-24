part of 'appcontrorller_cubit.dart';

abstract class AppcontrorllerState extends Equatable {
  const AppcontrorllerState();

  @override
  List<Object> get props => [];
}

class AppcontrorllerInitial extends AppcontrorllerState {}
class GetValFromSPState extends AppcontrorllerState {}
class ChangeToDarkState extends AppcontrorllerState {}

