class UserModel {
  String? message;
  User? user;

  UserModel({this.message, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? email;
  String? username;
  String? firstName;
  String? lastName;
  String? role;
  dynamic profilePic;
  dynamic phoneNumber;
  dynamic jobTitle;
  dynamic timezone;
  dynamic bio;
  dynamic preferences;
  bool? isActive;
  bool? isOwner;
  String? createdAt;
  String? updatedAt;
  String? lastLogin;
  dynamic department;
  dynamic organization;
  List<dynamic>? permissions;
  List<dynamic>? teamMemberships;
  List<dynamic>? activityLogs;

  User({
    this.id,
    this.email,
    this.username,
    this.firstName,
    this.lastName,
    this.role,
    this.profilePic,
    this.phoneNumber,
    this.jobTitle,
    this.timezone,
    this.bio,
    this.preferences,
    this.isActive,
    this.isOwner,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
    this.department,
    this.organization,
    this.permissions,
    this.teamMemberships,
    this.activityLogs,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    role = json['role'];
    profilePic = json['profilePic'];
    phoneNumber = json['phoneNumber'];
    jobTitle = json['jobTitle'];
    timezone = json['timezone'];
    bio = json['bio'];
    preferences = json['preferences'];
    isActive = json['isActive'];
    isOwner = json['isOwner'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    lastLogin = json['lastLogin'];
    department = json['department'];
    organization = json['organization'];
    permissions = json['permissions'];
    teamMemberships = json['teamMemberships'];
    activityLogs = json['activityLogs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['role'] = role;
    data['profilePic'] = profilePic;
    data['phoneNumber'] = phoneNumber;
    data['jobTitle'] = jobTitle;
    data['timezone'] = timezone;
    data['bio'] = bio;
    data['preferences'] = preferences;
    data['isActive'] = isActive;
    data['isOwner'] = isOwner;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['lastLogin'] = lastLogin;
    data['department'] = department;
    data['organization'] = organization;
    data['permissions'] = permissions;
    data['teamMemberships'] = teamMemberships;
    data['activityLogs'] = activityLogs;
    return data;
  }
}
