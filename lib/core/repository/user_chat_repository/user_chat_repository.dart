 
abstract class UserChatRepository {
  Future sendMessage(
      {required String message,
      required String reciverId,
      required String description,
      required String msgType});
  Future pickImageOrVideo(
      {required bool isCamera,
      required bool isVideo,
      required bool isPdf,
      required String type,
      required context,
      required String reciverId});
}
