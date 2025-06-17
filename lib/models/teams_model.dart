class TeamsModel {
  bool? success;
  TeamsData? data;

  TeamsModel({this.success, this.data});

  factory TeamsModel.fromJson(Map<String, dynamic> json) {
    return TeamsModel(
      success: json['success'],
      data: json['data'] != null ? TeamsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class TeamsData {
  List<Team>? teams;
  Pagination? pagination;

  TeamsData({this.teams, this.pagination});

  factory TeamsData.fromJson(Map<String, dynamic> json) {
    return TeamsData(
      teams: (json['teams'] as List?)?.map((e) => Team.fromJson(e)).toList(),
      pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teams': teams?.map((e) => e.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}

class Team {
  String? id;
  String? name;
  String? description;
  String? createdBy;
  String? organizationId;
  String? departmentId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? avatar;
  List<Member>? members;
  TeamUser? creator;

  Team({
    this.id,
    this.name,
    this.description,
    this.createdBy,
    this.organizationId,
    this.departmentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.avatar,
    this.members,
    this.creator,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdBy: json['createdBy'],
      organizationId: json['organizationId'],
      departmentId: json['departmentId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      avatar: json['avatar'],
      members: (json['members'] as List?)?.map((e) => Member.fromJson(e)).toList(),
      creator: json['creator'] != null ? TeamUser.fromJson(json['creator']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdBy': createdBy,
      'organizationId': organizationId,
      'departmentId': departmentId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'avatar': avatar,
      'members': members?.map((e) => e.toJson()).toList(),
      'creator': creator?.toJson(),
    };
  }
}

class Member {
  String? id;
  String? teamId;
  String? userId;
  String? role;
  String? joinedAt;
  bool? isActive;
  String? deletedAt;
  TeamUser? user;

  Member({
    this.id,
    this.teamId,
    this.userId,
    this.role,
    this.joinedAt,
    this.isActive,
    this.deletedAt,
    this.user,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      teamId: json['teamId'],
      userId: json['userId'],
      role: json['role'],
      joinedAt: json['joinedAt'],
      isActive: json['isActive'],
      deletedAt: json['deletedAt'],
      user: json['user'] != null ? TeamUser.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamId': teamId,
      'userId': userId,
      'role': role,
      'joinedAt': joinedAt,
      'isActive': isActive,
      'deletedAt': deletedAt,
      'user': user?.toJson(),
    };
  }
}

class TeamUser {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePic;

  TeamUser({this.id, this.firstName, this.lastName, this.email, this.profilePic});

  factory TeamUser.fromJson(Map<String, dynamic> json) {
    return TeamUser(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      profilePic: json['profilePic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profilePic': profilePic,
    };
  }
}

class Pagination {
  int? page;
  int? limit;
  int? totalItems;
  int? totalPages;

  Pagination({this.page, this.limit, this.totalItems, this.totalPages});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      limit: json['limit'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'totalItems': totalItems,
      'totalPages': totalPages,
    };
  }
}
