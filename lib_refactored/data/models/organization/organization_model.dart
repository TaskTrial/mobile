class OrganizationModel {
  final int? id;
  final String? name;
  final String? description;
  final String? logo;
  final String? website;
  final String? email;
  final String? phone;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? timezone;
  final String? language;
  final String? status;
  final int? ownerId;
  final String? ownerName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<OrganizationMemberModel>? members;
  final List<OrganizationProjectModel>? projects;
  final List<OrganizationTeamModel>? teams;
  final Map<String, dynamic>? settings;
  final int? memberCount;
  final int? projectCount;
  final int? teamCount;

  OrganizationModel({
    this.id,
    this.name,
    this.description,
    this.logo,
    this.website,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.timezone,
    this.language,
    this.status,
    this.ownerId,
    this.ownerName,
    this.createdAt,
    this.updatedAt,
    this.members,
    this.projects,
    this.teams,
    this.settings,
    this.memberCount,
    this.projectCount,
    this.teamCount,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      logo: json['logo'],
      website: json['website'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postalCode'],
      timezone: json['timezone'],
      language: json['language'],
      status: json['status'],
      ownerId: json['ownerId'],
      ownerName: json['ownerName'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
      members: json['members'] != null 
          ? List<OrganizationMemberModel>.from(json['members'].map((x) => OrganizationMemberModel.fromJson(x)))
          : null,
      projects: json['projects'] != null 
          ? List<OrganizationProjectModel>.from(json['projects'].map((x) => OrganizationProjectModel.fromJson(x)))
          : null,
      teams: json['teams'] != null 
          ? List<OrganizationTeamModel>.from(json['teams'].map((x) => OrganizationTeamModel.fromJson(x)))
          : null,
      settings: json['settings'],
      memberCount: json['memberCount'],
      projectCount: json['projectCount'],
      teamCount: json['teamCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'website': website,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'timezone': timezone,
      'language': language,
      'status': status,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'members': members?.map((x) => x.toJson()).toList(),
      'projects': projects?.map((x) => x.toJson()).toList(),
      'teams': teams?.map((x) => x.toJson()).toList(),
      'settings': settings,
      'memberCount': memberCount,
      'projectCount': projectCount,
      'teamCount': teamCount,
    };
  }

  bool get isActive => status == 'active';
  bool get isInactive => status == 'inactive';
  bool get isSuspended => status == 'suspended';

  String get statusDisplay {
    switch (status) {
      case 'active':
        return 'Active';
      case 'inactive':
        return 'Inactive';
      case 'suspended':
        return 'Suspended';
      default:
        return 'Unknown';
    }
  }

  String get fullAddress {
    final parts = <String>[];
    if (address != null && address!.isNotEmpty) parts.add(address!);
    if (city != null && city!.isNotEmpty) parts.add(city!);
    if (state != null && state!.isNotEmpty) parts.add(state!);
    if (postalCode != null && postalCode!.isNotEmpty) parts.add(postalCode!);
    if (country != null && country!.isNotEmpty) parts.add(country!);
    return parts.join(', ');
  }

  @override
  String toString() {
    return 'OrganizationModel{id: $id, name: $name, memberCount: $memberCount, projectCount: $projectCount}';
  }

  OrganizationModel copyWith({
    int? id,
    String? name,
    String? description,
    String? logo,
    String? website,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    String? timezone,
    String? language,
    String? status,
    int? ownerId,
    String? ownerName,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OrganizationMemberModel>? members,
    List<OrganizationProjectModel>? projects,
    List<OrganizationTeamModel>? teams,
    Map<String, dynamic>? settings,
    int? memberCount,
    int? projectCount,
    int? teamCount,
  }) {
    return OrganizationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      website: website ?? this.website,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      timezone: timezone ?? this.timezone,
      language: language ?? this.language,
      status: status ?? this.status,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      members: members ?? this.members,
      projects: projects ?? this.projects,
      teams: teams ?? this.teams,
      settings: settings ?? this.settings,
      memberCount: memberCount ?? this.memberCount,
      projectCount: projectCount ?? this.projectCount,
      teamCount: teamCount ?? this.teamCount,
    );
  }
}

class OrganizationMemberModel {
  final int? id;
  final int? organizationId;
  final int? userId;
  final String? userName;
  final String? userEmail;
  final String? userAvatar;
  final String? role;
  final DateTime? joinedAt;
  final String? status;
  final Map<String, dynamic>? permissions;

  OrganizationMemberModel({
    this.id,
    this.organizationId,
    this.userId,
    this.userName,
    this.userEmail,
    this.userAvatar,
    this.role,
    this.joinedAt,
    this.status,
    this.permissions,
  });

  factory OrganizationMemberModel.fromJson(Map<String, dynamic> json) {
    return OrganizationMemberModel(
      id: json['id'],
      organizationId: json['organizationId'],
      userId: json['userId'],
      userName: json['userName'],
      userEmail: json['userEmail'],
      userAvatar: json['userAvatar'],
      role: json['role'],
      joinedAt: json['joinedAt'] != null 
          ? DateTime.parse(json['joinedAt']) 
          : null,
      status: json['status'],
      permissions: json['permissions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userAvatar': userAvatar,
      'role': role,
      'joinedAt': joinedAt?.toIso8601String(),
      'status': status,
      'permissions': permissions,
    };
  }

  bool get isOwner => role == 'owner';
  bool get isAdmin => role == 'admin';
  bool get isMember => role == 'member';
  bool get isViewer => role == 'viewer';
  bool get isActive => status == 'active';
  bool get isPending => status == 'pending';
  bool get isSuspended => status == 'suspended';

  String get roleDisplay {
    switch (role) {
      case 'owner':
        return 'Owner';
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

class OrganizationProjectModel {
  final int? id;
  final int? organizationId;
  final int? projectId;
  final String? projectName;
  final String? projectDescription;
  final String? projectStatus;
  final DateTime? createdAt;

  OrganizationProjectModel({
    this.id,
    this.organizationId,
    this.projectId,
    this.projectName,
    this.projectDescription,
    this.projectStatus,
    this.createdAt,
  });

  factory OrganizationProjectModel.fromJson(Map<String, dynamic> json) {
    return OrganizationProjectModel(
      id: json['id'],
      organizationId: json['organizationId'],
      projectId: json['projectId'],
      projectName: json['projectName'],
      projectDescription: json['projectDescription'],
      projectStatus: json['projectStatus'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'projectId': projectId,
      'projectName': projectName,
      'projectDescription': projectDescription,
      'projectStatus': projectStatus,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}

class OrganizationTeamModel {
  final int? id;
  final int? organizationId;
  final int? teamId;
  final String? teamName;
  final String? teamDescription;
  final String? teamStatus;
  final DateTime? createdAt;

  OrganizationTeamModel({
    this.id,
    this.organizationId,
    this.teamId,
    this.teamName,
    this.teamDescription,
    this.teamStatus,
    this.createdAt,
  });

  factory OrganizationTeamModel.fromJson(Map<String, dynamic> json) {
    return OrganizationTeamModel(
      id: json['id'],
      organizationId: json['organizationId'],
      teamId: json['teamId'],
      teamName: json['teamName'],
      teamDescription: json['teamDescription'],
      teamStatus: json['teamStatus'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'teamId': teamId,
      'teamName': teamName,
      'teamDescription': teamDescription,
      'teamStatus': teamStatus,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}