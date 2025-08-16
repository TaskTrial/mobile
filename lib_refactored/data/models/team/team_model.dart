class TeamModel {
  final int? id;
  final String? name;
  final String? description;
  final String? avatar;
  final int? organizationId;
  final String? organizationName;
  final int? createdBy;
  final String? createdByName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<TeamMemberModel>? members;
  final List<TeamProjectModel>? projects;
  final String? status;
  final int? memberCount;
  final int? projectCount;

  TeamModel({
    this.id,
    this.name,
    this.description,
    this.avatar,
    this.organizationId,
    this.organizationName,
    this.createdBy,
    this.createdByName,
    this.createdAt,
    this.updatedAt,
    this.members,
    this.projects,
    this.status,
    this.memberCount,
    this.projectCount,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      avatar: json['avatar'],
      organizationId: json['organizationId'],
      organizationName: json['organizationName'],
      createdBy: json['createdBy'],
      createdByName: json['createdByName'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
      members: json['members'] != null 
          ? List<TeamMemberModel>.from(json['members'].map((x) => TeamMemberModel.fromJson(x)))
          : null,
      projects: json['projects'] != null 
          ? List<TeamProjectModel>.from(json['projects'].map((x) => TeamProjectModel.fromJson(x)))
          : null,
      status: json['status'],
      memberCount: json['memberCount'],
      projectCount: json['projectCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'avatar': avatar,
      'organizationId': organizationId,
      'organizationName': organizationName,
      'createdBy': createdBy,
      'createdByName': createdByName,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'members': members?.map((x) => x.toJson()).toList(),
      'projects': projects?.map((x) => x.toJson()).toList(),
      'status': status,
      'memberCount': memberCount,
      'projectCount': projectCount,
    };
  }

  bool get isActive => status == 'active';
  bool get isInactive => status == 'inactive';
  bool get isArchived => status == 'archived';

  String get statusDisplay {
    switch (status) {
      case 'active':
        return 'Active';
      case 'inactive':
        return 'Inactive';
      case 'archived':
        return 'Archived';
      default:
        return 'Unknown';
    }
  }

  @override
  String toString() {
    return 'TeamModel{id: $id, name: $name, memberCount: $memberCount, projectCount: $projectCount}';
  }

  TeamModel copyWith({
    int? id,
    String? name,
    String? description,
    String? avatar,
    int? organizationId,
    String? organizationName,
    int? createdBy,
    String? createdByName,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TeamMemberModel>? members,
    List<TeamProjectModel>? projects,
    String? status,
    int? memberCount,
    int? projectCount,
  }) {
    return TeamModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      avatar: avatar ?? this.avatar,
      organizationId: organizationId ?? this.organizationId,
      organizationName: organizationName ?? this.organizationName,
      createdBy: createdBy ?? this.createdBy,
      createdByName: createdByName ?? this.createdByName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      members: members ?? this.members,
      projects: projects ?? this.projects,
      status: status ?? this.status,
      memberCount: memberCount ?? this.memberCount,
      projectCount: projectCount ?? this.projectCount,
    );
  }
}

class TeamMemberModel {
  final int? id;
  final int? teamId;
  final int? userId;
  final String? userName;
  final String? userEmail;
  final String? userAvatar;
  final String? role;
  final DateTime? joinedAt;
  final String? status;

  TeamMemberModel({
    this.id,
    this.teamId,
    this.userId,
    this.userName,
    this.userEmail,
    this.userAvatar,
    this.role,
    this.joinedAt,
    this.status,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberModel(
      id: json['id'],
      teamId: json['teamId'],
      userId: json['userId'],
      userName: json['userName'],
      userEmail: json['userEmail'],
      userAvatar: json['userAvatar'],
      role: json['role'],
      joinedAt: json['joinedAt'] != null 
          ? DateTime.parse(json['joinedAt']) 
          : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamId': teamId,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userAvatar': userAvatar,
      'role': role,
      'joinedAt': joinedAt?.toIso8601String(),
      'status': status,
    };
  }

  bool get isAdmin => role == 'admin';
  bool get isMember => role == 'member';
  bool get isViewer => role == 'viewer';
  bool get isActive => status == 'active';
  bool get isPending => status == 'pending';

  String get roleDisplay {
    switch (role) {
      case 'admin':
        return 'Admin';
      case 'member':
        return 'Member';
      case 'viewer':
        return 'Viewer';
      default:
        return 'Member';
    }
  }
}

class TeamProjectModel {
  final int? id;
  final int? teamId;
  final int? projectId;
  final String? projectName;
  final String? projectDescription;
  final String? projectStatus;
  final DateTime? assignedAt;

  TeamProjectModel({
    this.id,
    this.teamId,
    this.projectId,
    this.projectName,
    this.projectDescription,
    this.projectStatus,
    this.assignedAt,
  });

  factory TeamProjectModel.fromJson(Map<String, dynamic> json) {
    return TeamProjectModel(
      id: json['id'],
      teamId: json['teamId'],
      projectId: json['projectId'],
      projectName: json['projectName'],
      projectDescription: json['projectDescription'],
      projectStatus: json['projectStatus'],
      assignedAt: json['assignedAt'] != null 
          ? DateTime.parse(json['assignedAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamId': teamId,
      'projectId': projectId,
      'projectName': projectName,
      'projectDescription': projectDescription,
      'projectStatus': projectStatus,
      'assignedAt': assignedAt?.toIso8601String(),
    };
  }
}