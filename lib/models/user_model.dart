class UserModel {
  String? name;
  String? email;
  String? uid;
  String? role;

  bool? isActive;

  UserModel({this.name, this.email, this.uid, this.role,this.isActive});
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uid = json['uid'];
    role = json['role'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['uid'] = uid;
    data['role'] = role;
    data['isActive'] = isActive;
    return data;
  }

}