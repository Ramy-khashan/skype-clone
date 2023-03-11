part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}
class ShowPasswordState extends SignInState {}
class LoadingSignInState extends SignInState {} 
class FaildSignInState extends SignInState {} 
class SuccessgSignInState extends SignInState {}
 class LoadingSignInGoogleState extends SignInState {} 
class FaildSignInGoogleState extends SignInState {} 
class SuccessgSignInGoogleState extends SignInState {} 
