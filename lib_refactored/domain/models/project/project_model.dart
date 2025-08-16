import '../../data/models/project/project_model.dart' as data;

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

  factory ProjectModel.fromDataModel(data.ProjectModel dataModel) {
    return ProjectModel(
      id: dataModel.id,
      name: dataModel.name,
      description: dataModel.description,
      status: dataModel.status,
      startDate: dataModel.startDate,
      endDate: dataModel.endDate,
      organizationId: dataModel.organizationId,
      organizationName: dataModel.organizationName,
      createdBy: dataModel.createdBy,
      createdByName: dataModel.createdByName,
      createdAt: dataModel.createdAt,
      updatedAt: dataModel.updatedAt,
      teams: dataModel.teams?.map((t) => TeamModel.fromDataModel(t)).toList(),
      tasks: dataModel.tasks?.map((t) => TaskModel.fromDataModel(t)).toList(),
      totalTasks: dataModel.totalTasks,
      completedTasks: dataModel.completedTasks,
      progress: dataModel.progress,
    );
  }

  data.ProjectModel toDataModel() {
    return data.ProjectModel(
      id: id,
      name: name,
      description: description,
      status: status,
      startDate: startDate,
      endDate: endDate,
      organizationId: organizationId,
      organizationName: organizationName,
      createdBy: createdBy,
      createdByName: createdByName,
      createdAt: createdAt,
      updatedAt: updatedAt,
      teams: teams?.map((t) => t.toDataModel()).toList(),
      tasks: tasks?.map((t) => t.toDataModel()).toList(),
      totalTasks: totalTasks,
      completedTasks: completedTasks,
      progress: progress,
    );
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

// Domain models for compilation
class TeamModel {
  final int? id;
  final String? name;

  TeamModel({this.id, this.name});

  factory TeamModel.fromDataModel(data.TeamModel dataModel) {
    return TeamModel(
      id: dataModel.id,
      name: dataModel.name,
    );
  }

  data.TeamModel toDataModel() {
    return data.TeamModel(
      id: id,
      name: name,
    );
  }
}

class TaskModel {
  final int? id;
  final String? title;
  final String? status;

  TaskModel({this.id, this.title, this.status});

  factory TaskModel.fromDataModel(data.TaskModel dataModel) {
    return TaskModel(
      id: dataModel.id,
      title: dataModel.title,
      status: dataModel.status,
    );
  }

  data.TaskModel toDataModel() {
    return data.TaskModel(
      id: id,
      title: title,
      status: status,
    );
  }
}