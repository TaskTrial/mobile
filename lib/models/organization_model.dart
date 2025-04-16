class OrganizationModel {
  final String? id;
  final String? name;
  final String? description;
  final String? industry;
  final String? sizeRange;
  final String? website;
  final String? logoUrl;
  final bool? isVerified;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? createdBy;
  final String? address;
  final String? contactEmail;
  final String? contactPhone;
  final String? emailVerificationOTP;
  final String? emailVerificationExpires;
  final List<Owner>? owners;
  final List<dynamic>? departments;
  final List<dynamic>? teams;
  final List<dynamic>? projects;
  final Statistics? statistics;
  final bool? hasMoreDepartments;
  final bool? hasMoreTeams;
  final bool? hasMoreProjects;

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
    this.statistics,
    this.hasMoreDepartments,
    this.hasMoreTeams,
    this.hasMoreProjects,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    return OrganizationModel(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      industry: data['industry'],
      sizeRange: data['sizeRange'],
      website: data['website'],
      logoUrl: data['logoUrl'],
      isVerified: data['isVerified'],
      status: data['status'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      deletedAt: data['deletedAt'],
      createdBy: data['createdBy'],
      address: data['address'],
      contactEmail: data['contactEmail'],
      contactPhone: data['contactPhone'],
      emailVerificationOTP: data['emailVerificationOTP'],
      emailVerificationExpires: data['emailVerificationExpires'],
      owners: data['owners'] != null
          ? List<Owner>.from(data['owners'].map((x) => Owner.fromJson(x)))
          : null,
      departments: data['departments'] ?? [],
      teams: data['teams'] ?? [],
      projects: data['projects'] ?? [],
      statistics: data['statistics'] != null
          ? Statistics.fromJson(data['statistics'])
          : null,
      hasMoreDepartments: data['hasMoreDepartments'],
      hasMoreTeams: data['hasMoreTeams'],
      hasMoreProjects: data['hasMoreProjects'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "industry": industry,
    "sizeRange": sizeRange,
    "website": website,
    "logoUrl": logoUrl,
    "isVerified": isVerified,
    "status": status,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "deletedAt": deletedAt,
    "createdBy": createdBy,
    "address": address,
    "contactEmail": contactEmail,
    "contactPhone": contactPhone,
    "emailVerificationOTP": emailVerificationOTP,
    "emailVerificationExpires": emailVerificationExpires,
    "owners": owners?.map((x) => x.toJson()).toList(),
    "departments": departments,
    "teams": teams,
    "projects": projects,
    "statistics": statistics?.toJson(),
    "hasMoreDepartments": hasMoreDepartments,
    "hasMoreTeams": hasMoreTeams,
    "hasMoreProjects": hasMoreProjects,
  };
}

class Owner {
  final String? id;
  final String? name;
  final String? email;
  final String? profileImage;

  Owner({
    this.id,
    this.name,
    this.email,
    this.profileImage,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'profileImage': profileImage,
  };
}

class Statistics {
  final int? usersCount;
  final int? departmentsCount;
  final int? teamsCount;
  final int? projectsCount;
  final int? templatesCount;

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

  Map<String, dynamic> toJson() => {
    'usersCount': usersCount,
    'departmentsCount': departmentsCount,
    'teamsCount': teamsCount,
    'projectsCount': projectsCount,
    'templatesCount': templatesCount,
  };
}
