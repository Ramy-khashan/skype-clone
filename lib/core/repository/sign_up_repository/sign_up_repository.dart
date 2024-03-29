import 'package:dartz/dartz.dart';
import '../../api/exceptions.dart';

abstract class SignUpRepository {
  Future<Either<ServerException, String>> signUpMethod(
      {required String email,
      required String password,
      required String name,
      required String phone});
 
}
