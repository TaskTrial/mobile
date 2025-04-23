class TaskModel {
  String? id;
  String? title;
  String? description;
  String? priority;
  String? status;
  String? dueDate;
  String? createdAt;
  String? updatedAt;
  int? estimatedTime;
  int? actualTime;
  int? timeRemaining;
  int? timeProgress;
  List<String>? labels;
  Project? project;
  User? creator;
  User? assignee;
  int? commentCount;
  int? attachmentCount;
  int? timelogCount;
  bool? isOverdue;
  int? progress;
  SubtaskStats? subtaskStats;
  List<Subtask>? subtasks;
  bool? hasMoreSubtasks;

  TaskModel();

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel()
    ..id = json['id']
    ..title = json['title']
    ..description = json['description']
    ..priority = json['priority']
    ..status = json['status']
    ..dueDate = json['dueDate']
    ..createdAt = json['createdAt']
    ..updatedAt = json['updatedAt']
    ..estimatedTime = json['estimatedTime']
    ..actualTime = json['actualTime']
    ..timeRemaining = json['timeRemaining']
    ..timeProgress = json['timeProgress']
    ..labels = (json['labels'] as List?)?.cast<String>()
    ..project = json['project'] != null ? Project.fromJson(json['project']) : null
    ..creator = json['creator'] != null ? User.fromJson(json['creator']) : null
    ..assignee = json['assignee'] != null ? User.fromJson(json['assignee']) : null
    ..commentCount = json['commentCount']
    ..attachmentCount = json['attachmentCount']
    ..timelogCount = json['timelogCount']
    ..isOverdue = json['isOverdue']
    ..progress = json['progress']
    ..subtaskStats = json['subtaskStats'] != null ? SubtaskStats.fromJson(json['subtaskStats']) : null
    ..subtasks = (json['subtasks'] as List?)?.map((x) => Subtask.fromJson(x)).toList()
    ..hasMoreSubtasks = json['hasMoreSubtasks'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'priority': priority,
    'status': status,
    'dueDate': dueDate,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'estimatedTime': estimatedTime,
    'actualTime': actualTime,
    'timeRemaining': timeRemaining,
    'timeProgress': timeProgress,
    'labels': labels,
    'project': project?.toJson(),
    'creator': creator?.toJson(),
    'assignee': assignee?.toJson(),
    'commentCount': commentCount,
    'attachmentCount': attachmentCount,
    'timelogCount': timelogCount,
    'isOverdue': isOverdue,
    'progress': progress,
    'subtaskStats': subtaskStats?.toJson(),
    'subtasks': subtasks?.map((x) => x.toJson()).toList(),
    'hasMoreSubtasks': hasMoreSubtasks,
  };
}

class Project {
  String? id;
  String? name;
  String? status;

  Project();

  factory Project.fromJson(Map<String, dynamic> json) => Project()
    ..id = json['id']
    ..name = json['name']
    ..status = json['status'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
  };
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePic;

  User();

  factory User.fromJson(Map<String, dynamic> json) => User()
    ..id = json['id']
    ..firstName = json['firstName']
    ..lastName = json['lastName']
    ..email = json['email']
    ..profilePic = json['profilePic'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'profilePic': profilePic,
  };
}

class Subtask {
  String? id;
  String? title;
  String? status;
  String? priority;
  String? assignedTo;
  String? dueDate;
  SubtaskAssignee? assignee;

  Subtask();

  factory Subtask.fromJson(Map<String, dynamic> json) => Subtask()
    ..id = json['id']
    ..title = json['title']
    ..status = json['status']
    ..priority = json['priority']
    ..assignedTo = json['assignedTo']
    ..dueDate = json['dueDate']
    ..assignee = json['assignee'] != null ? SubtaskAssignee.fromJson(json['assignee']) : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'status': status,
    'priority': priority,
    'assignedTo': assignedTo,
    'dueDate': dueDate,
    'assignee': assignee?.toJson(),
  };
}

class SubtaskAssignee {
  String? id;
  String? firstName;
  String? lastName;
  String? email;

  SubtaskAssignee();

  factory SubtaskAssignee.fromJson(Map<String, dynamic> json) => SubtaskAssignee()
    ..id = json['id']
    ..firstName = json['firstName']
    ..lastName = json['lastName']
    ..email = json['email'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
  };
}

class SubtaskStats {
  int? total;
  int? completed;
  int? inProgress;
  int? notStarted;
  int? overdue;

  SubtaskStats();

  factory SubtaskStats.fromJson(Map<String, dynamic> json) => SubtaskStats()
    ..total = json['total']
    ..completed = json['completed']
    ..inProgress = json['inProgress']
    ..notStarted = json['notStarted']
    ..overdue = json['overdue'];

  Map<String, dynamic> toJson() => {
    'total': total,
    'completed': completed,
    'inProgress': inProgress,
    'notStarted': notStarted,
    'overdue': overdue,
  };
}
