part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}
class ShowPasswordState extends SignUpState {}
class LoadingSignUpState extends SignUpState {} 
class FaildSignUpState extends SignUpState {} 
class SuccessgSignUpState extends SignUpState {} 
