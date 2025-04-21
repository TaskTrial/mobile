

class ProjectModel {
  final String id;
  final String name;
  final String description;
  final String status;
  final String createdBy;
  final String organizationId;
  final String teamId;
  final String startDate;
  final String endDate;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String priority;
  final int progress;
  final dynamic budget;
  final String lastModifiedBy;
  final int memberCount;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.createdBy,
    required this.organizationId,
    required this.teamId,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.priority,
    required this.progress,
    this.budget,
    required this.lastModifiedBy,
    required this.memberCount,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      createdBy: json['createdBy'],
      organizationId: json['organizationId'],
      teamId: json['teamId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      priority: json['priority'],
      progress: json['progress'],
      budget: json['budget'],
      lastModifiedBy: json['lastModifiedBy'],
      memberCount: json['memberCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'createdBy': createdBy,
      'organizationId': organizationId,
      'teamId': teamId,
      'startDate': startDate,
      'endDate': endDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'priority': priority,
      'progress': progress,
      'budget': budget,
      'lastModifiedBy': lastModifiedBy,
      'memberCount': memberCount,
    };
  }
}
