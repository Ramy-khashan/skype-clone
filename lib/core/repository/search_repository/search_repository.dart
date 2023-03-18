import 'package:dartz/dartz.dart';
import 'package:skype/modules/chats/model/user_model.dart';

abstract class SearchRepository {
  Future<Either<String, List<UserModel>>> getUSuserBySearch();
  Future addFrind({
    required String name,
    required String reciverId,
  });
  Future addFriendToUser({
    required String friendId,
    context
  });
}
