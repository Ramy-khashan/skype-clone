abstract class AppRepository{
  Future onGetUserSavedData();
  Future getFrindsIds();
  Future getFrindsData({required List friendsId});
}