import 'package:dartz/dartz.dart';
import 'package:skype/core/api/exceptions.dart';

abstract class SignInRepository {
  Future<Either<ServerException, String>> signIn(
      {required String email, required String password});
  Future<Either<ServerException, String>> forgetPassword();
}
