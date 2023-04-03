abstract class GroupChatRepository {
  Future sendMessage(
      {required String message,
      required String groupId,
      required String description,
      required String msgType});
  Future pickImageOrVideo({
    required bool isCamera,
    required bool isVideo,
    required bool isPdf,
    required String type,
    required String groupId,
    required context,
  });
}
