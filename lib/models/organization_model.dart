class OrganizationModel {
  final String id;
  final String name;
  final String? description;
  final String industry;
  final String sizeRange;
  final String? website;
  final String? logoUrl;
  final bool isVerified;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String? address;
  final String contactEmail;
  final String? contactPhone;
  final String emailVerificationOTP;
  final DateTime emailVerificationExpires;
  final List<Owner> owners;
  final List<dynamic> departments;
  final List<dynamic> teams;
  final List<dynamic> projects;
  final Statistics statistics;
  final bool hasMoreDepartments;
  final bool hasMoreTeams;
  final bool hasMoreProjects;

  OrganizationModel({
    required this.id,
    required this.name,
    this.description,
    required this.industry,
    required this.sizeRange,
    this.website,
    this.logoUrl,
    required this.isVerified,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.address,
    required this.contactEmail,
    this.contactPhone,
    required this.emailVerificationOTP,
    required this.emailVerificationExpires,
    required this.owners,
    required this.departments,
    required this.teams,
    required this.projects,
    required this.statistics,
    required this.hasMoreDepartments,
    required this.hasMoreTeams,
    required this.hasMoreProjects,
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
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      createdBy: json['createdBy'],
      address: json['address'],
      contactEmail: json['contactEmail'],
      contactPhone: json['contactPhone'],
      emailVerificationOTP: json['emailVerificationOTP'],
      emailVerificationExpires: DateTime.parse(json['emailVerificationExpires']),
      owners: (json['owners'] as List).map((e) => Owner.fromJson(e)).toList(),
      departments: json['departments'],
      teams: json['teams'],
      projects: json['projects'],
      statistics: Statistics.fromJson(json['statistics']),
      hasMoreDepartments: json['hasMoreDepartments'],
      hasMoreTeams: json['hasMoreTeams'],
      hasMoreProjects: json['hasMoreProjects'],
    );
  }
}

class Owner {
  final String id;
  final String name;
  final String email;
  final String profileImage;

  Owner({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
    );
  }
}

class Statistics {
  final int usersCount;
  final int departmentsCount;
  final int teamsCount;
  final int projectsCount;
  final int templatesCount;

  Statistics({
    required this.usersCount,
    required this.departmentsCount,
    required this.teamsCount,
    required this.projectsCount,
    required this.templatesCount,
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
}
