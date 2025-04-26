class OrganizationModel {
  String? id;
  String? name;
  String? description;
  String? industry;
  String? sizeRange;
  String? website;
  String? logoUrl;
  bool? isVerified;
  String? status;
  String? joinCode;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdBy;
  String? address;
  String? contactEmail;
  String? contactPhone;
  String? emailVerificationOTP;
  String? emailVerificationExpires;
  List<Owner>? owners;
  List<dynamic>? departments;
  List<dynamic>? teams;
  List<dynamic>? projects;
  List<User>? users;
  Statistics? statistics;
  bool? hasMoreDepartments;
  bool? hasMoreTeams;
  bool? hasMoreProjects;

  OrganizationModel({
    this.id,
    this.name,
    this.description,
    this.industry,
    this.sizeRange,
    this.website,
    this.logoUrl,
    this.isVerified,
    this.status,
    this.joinCode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.address,
    this.contactEmail,
    this.contactPhone,
    this.emailVerificationOTP,
    this.emailVerificationExpires,
    this.owners,
    this.departments,
    this.teams,
    this.projects,
    this.users,
    this.statistics,
    this.hasMoreDepartments,
    this.hasMoreTeams,
    this.hasMoreProjects,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      industry: json['industry'],
      sizeRange: json['sizeRange'],
      website: json['website'],
      logoUrl: json['logoUrl'],
      isVerified: json['isVerified'],
      status: json['status'],
      joinCode: json['joinCode'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      createdBy: json['createdBy'],
      address: json['address'],
      contactEmail: json['contactEmail'],
      contactPhone: json['contactPhone'],
      emailVerificationOTP: json['emailVerificationOTP'],
      emailVerificationExpires: json['emailVerificationExpires'],
      owners: (json['owners'] as List<dynamic>?)
          ?.map((e) => Owner.fromJson(e))
          .toList(),
      departments: json['departments'],
      teams: json['teams'],
      projects: json['projects'],
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e))
          .toList(),
      statistics: json['statistics'] != null
          ? Statistics.fromJson(json['statistics'])
          : null,
      hasMoreDepartments: json['hasMoreDepartments'],
      hasMoreTeams: json['hasMoreTeams'],
      hasMoreProjects: json['hasMoreProjects'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'industry': industry,
      'sizeRange': sizeRange,
      'website': website,
      'logoUrl': logoUrl,
      'isVerified': isVerified,
      'status': status,
      'joinCode': joinCode,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'createdBy': createdBy,
      'address': address,
      'contactEmail': contactEmail,
      'contactPhone': contactPhone,
      'emailVerificationOTP': emailVerificationOTP,
      'emailVerificationExpires': emailVerificationExpires,
      'owners': owners?.map((e) => e.toJson()).toList(),
      'departments': departments,
      'teams': teams,
      'projects': projects,
      'users': users?.map((e) => e.toJson()).toList(),
      'statistics': statistics?.toJson(),
      'hasMoreDepartments': hasMoreDepartments,
      'hasMoreTeams': hasMoreTeams,
      'hasMoreProjects': hasMoreProjects,
    };
  }
}

class Owner {
  String? id;
  String? name;
  String? email;
  String? profileImage;

  Owner({this.id, this.name, this.email, this.profileImage});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
    };
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePic;
  String? jobTitle;
  String? role;
  bool? isOwner;
  dynamic department;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.profilePic,
    this.jobTitle,
    this.role,
    this.isOwner,
    this.department,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      profilePic: json['profilePic'],
      jobTitle: json['jobTitle'],
      role: json['role'],
      isOwner: json['isOwner'],
      department: json['department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profilePic': profilePic,
      'jobTitle': jobTitle,
      'role': role,
      'isOwner': isOwner,
      'department': department,
    };
  }
}

class Statistics {
  int? usersCount;
  int? departmentsCount;
  int? teamsCount;
  int? projectsCount;
  int? templatesCount;

  Statistics({
    this.usersCount,
    this.departmentsCount,
    this.teamsCount,
    this.projectsCount,
    this.templatesCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      usersCount: json['usersCount'],
      departmentsCount: json['departmentsCount'],
      teamsCount: json['teamsCount'],
      projectsCount: json['projectsCount'],
      templatesCount: json['templatesCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usersCount': usersCount,
      'departmentsCount': departmentsCount,
      'teamsCount': teamsCount,
      'projectsCount': projectsCount,
      'templatesCount': templatesCount,
    };
  }
}
