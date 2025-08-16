class ProjectModel {
  final int? id;
  final String? name;
  final String? description;
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? organizationId;
  final String? organizationName;
  final int? createdBy;
  final String? createdByName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<TeamModel>? teams;
  final List<TaskModel>? tasks;
  final int? totalTasks;
  final int? completedTasks;
  final double? progress;

  ProjectModel({
    this.id,
    this.name,
    this.description,
    this.status,
    this.startDate,
    this.endDate,
    this.organizationId,
    this.organizationName,
    this.createdBy,
    this.createdByName,
    this.createdAt,
    this.updatedAt,
    this.teams,
    this.tasks,
    this.totalTasks,
    this.completedTasks,
    this.progress,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      startDate: json['startDate'] != null 
          ? DateTime.parse(json['startDate']) 
          : null,
      endDate: json['endDate'] != null 
          ? DateTime.parse(json['endDate']) 
          : null,
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
      teams: json['teams'] != null 
          ? List<TeamModel>.from(json['teams'].map((x) => TeamModel.fromJson(x)))
          : null,
      tasks: json['tasks'] != null 
          ? List<TaskModel>.from(json['tasks'].map((x) => TaskModel.fromJson(x)))
          : null,
      totalTasks: json['totalTasks'],
      completedTasks: json['completedTasks'],
      progress: json['progress']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'organizationId': organizationId,
      'organizationName': organizationName,
      'createdBy': createdBy,
      'createdByName': createdByName,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'teams': teams?.map((x) => x.toJson()).toList(),
      'tasks': tasks?.map((x) => x.toJson()).toList(),
      'totalTasks': totalTasks,
      'completedTasks': completedTasks,
      'progress': progress,
    };
  }

  double get progressPercentage {
    if (totalTasks == null || totalTasks == 0) return 0.0;
    return (completedTasks ?? 0) / totalTasks! * 100;
  }

  bool get isActive => status == 'active';
  bool get isCompleted => status == 'completed';
  bool get isOnHold => status == 'on_hold';
  bool get isCancelled => status == 'cancelled';

  String get statusDisplay {
    switch (status) {
      case 'active':
        return 'Active';
      case 'completed':
        return 'Completed';
      case 'on_hold':
        return 'On Hold';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  @override
  String toString() {
    return 'ProjectModel{id: $id, name: $name, status: $status, progress: $progressPercentage%}';
  }

  ProjectModel copyWith({
    int? id,
    String? name,
    String? description,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    int? organizationId,
    String? organizationName,
    int? createdBy,
    String? createdByName,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TeamModel>? teams,
    List<TaskModel>? tasks,
    int? totalTasks,
    int? completedTasks,
    double? progress,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      organizationId: organizationId ?? this.organizationId,
      organizationName: organizationName ?? this.organizationName,
      createdBy: createdBy ?? this.createdBy,
      createdByName: createdByName ?? this.createdByName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      teams: teams ?? this.teams,
      tasks: tasks ?? this.tasks,
      totalTasks: totalTasks ?? this.totalTasks,
      completedTasks: completedTasks ?? this.completedTasks,
      progress: progress ?? this.progress,
    );
  }
}

// Placeholder models for compilation
class TeamModel {
  final int? id;
  final String? name;

  TeamModel({this.id, this.name});

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class TaskModel {
  final int? id;
  final String? title;
  final String? status;

  TaskModel({this.id, this.title, this.status});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
    };
  }
}