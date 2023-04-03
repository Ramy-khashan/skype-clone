abstract class GroupRepository {
  Future onGetUserSavedData();
  Future getGroup();
  Future createGroup({required String name, required String image,required List groupMember});
  Future getFrindsIds();
  Future getFrindsData({required List friendsId});

}
