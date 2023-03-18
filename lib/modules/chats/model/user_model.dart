class UserModel {
    String? name;
    String ?image;
    String ?phone;
    String ?email;
    String ?userUid;
    String ?userid;

  UserModel(
      {required this.name,
      required this.image,
      required this.phone,
      required this.email,
      required this.userUid,
      required this.userid});
      
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    email = json['email'];
    userUid = json['user_uid'];
    userid  = json['user_id'];
     
  }
}
