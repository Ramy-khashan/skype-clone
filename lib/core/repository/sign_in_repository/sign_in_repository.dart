import 'package:dartz/dartz.dart';
import '../../api/exceptions.dart';

abstract class SignInRepository {
  Future<Either<ServerException, String>> signIn(
      {required String email, required String password,context,required  String token});
  Future<Either<ServerException, String>> forgetPassword();
  Future<Either<String, String>> signInWithGoogle(context,{required  String token});
}
