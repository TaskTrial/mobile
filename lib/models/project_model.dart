class ProjectModel {
  String? id;
  String? name;
  String? description;
  String? status;
  String? startDate;
  String? endDate;
  String? priority;
  int? progress;
  double? budget;
  TeamModel? team;
  String? createdAt;
  String? updatedAt;
  int? memberCount;
  List<MemberModel>? members;
  bool? hasMoreMembers;
  String? userRole;
  TaskStatsModel? taskStats;
  List<Task>? tasks;
  bool? hasMoreTasks;

  ProjectModel({
    this.id,
    this.name,
    this.description,
    this.status,
    this.startDate,
    this.endDate,
    this.priority,
    this.progress,
    this.budget,
    this.team,
    this.createdAt,
    this.updatedAt,
    this.memberCount,
    this.members,
    this.hasMoreMembers,
    this.userRole,
    this.taskStats,
    this.tasks,
    this.hasMoreTasks,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      priority: json['priority'],
      progress: json['progress'],
      budget: (json['budget'] != null) ? json['budget'].toDouble() : null,
      team: json['team'] != null ? TeamModel.fromJson(json['team']) : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      memberCount: json['memberCount'],
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => MemberModel.fromJson(e))
          .toList(),
      hasMoreMembers: json['hasMoreMembers'],
      userRole: json['userRole'],
      taskStats: json['taskStats'] != null
          ? TaskStatsModel.fromJson(json['taskStats'])
          : null,
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((e) => Task.fromJson(e))
          .toList(),
      hasMoreTasks: json['hasMoreTasks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'startDate': startDate,
      'endDate': endDate,
      'priority': priority,
      'progress': progress,
      'budget': budget,
      'team': team?.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'memberCount': memberCount,
      'members': members?.map((e) => e.toJson()).toList(),
      'hasMoreMembers': hasMoreMembers,
      'userRole': userRole,
      'taskStats': taskStats?.toJson(),
      'tasks': tasks?.map((e) => e.toJson()).toList(),
      'hasMoreTasks': hasMoreTasks,
    };
  }
}

class TeamModel {
  String? id;
  String? name;

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

class MemberModel {
  String? userId;
  String? role;
  String? firstName;
  String? lastName;
  String? profilePic;

  MemberModel({
    this.userId,
    this.role,
    this.firstName,
    this.lastName,
    this.profilePic,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      userId: json['userId'],
      role: json['role'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePic: json['profilePic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'role': role,
      'firstName': firstName,
      'lastName': lastName,
      'profilePic': profilePic,
    };
  }
}

class TaskStatsModel {
  int? total;
  int? notStarted;
  int? inProgress;
  int? completed;
  int? overdue;

  TaskStatsModel({
    this.total,
    this.notStarted,
    this.inProgress,
    this.completed,
    this.overdue,
  });

  factory TaskStatsModel.fromJson(Map<String, dynamic> json) {
    return TaskStatsModel(
      total: json['total'],
      notStarted: json['notStarted'],
      inProgress: json['inProgress'],
      completed: json['completed'],
      overdue: json['overdue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'notStarted': notStarted,
      'inProgress': inProgress,
      'completed': completed,
      'overdue': overdue,
    };
  }
}

class Task {
  String? id;
  String? title;
  String? description;
  String? priority;
  String? status;
  String? dueDate;
  dynamic estimatedTime;
  dynamic actualTime;
  List<dynamic>? labels;
  int? subtaskCount;
  int? commentCount;
  int? attachmentCount;
  dynamic assignee;
  bool? isOverdue;
  Task({
    this.id,
    this.title,
    this.description,
    this.priority,
    this.status,
    this.dueDate,
    this.estimatedTime,
    this.actualTime,
    this.labels,
    this.subtaskCount,
    this.commentCount,
    this.attachmentCount,
    this.assignee,
    this.isOverdue,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      status: json['status'],
      dueDate: json['dueDate'],
      estimatedTime: json['estimatedTime'],
      actualTime: json['actualTime'],
      labels: json['labels'] ?? [],
      subtaskCount: json['subtaskCount'],
      commentCount: json['commentCount'],
      attachmentCount: json['attachmentCount'],
      assignee: json['assignee'],
      isOverdue: json['isOverdue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'dueDate': dueDate,
      'estimatedTime': estimatedTime,
      'actualTime': actualTime,
      'labels': labels,
      'subtaskCount': subtaskCount,
      'commentCount': commentCount,
      'attachmentCount': attachmentCount,
      'assignee': assignee,
      'isOverdue': isOverdue,
    };
  }
}
