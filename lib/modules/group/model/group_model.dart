class GroupModel {
  final String name;
  final String image;
  final String groupId;
  final List member;
  final List admin;

  GroupModel(
      {required this.groupId,
      required this.name,
      required this.image,
      required this.member,
      required this.admin});
}
