class TaskModel {
  final int? id;
  final String? title;
  final String? description;
  final String? status;
  final String? priority;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final int? projectId;
  final String? projectName;
  final int? assignedTo;
  final String? assignedToName;
  final int? createdBy;
  final String? createdByName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<TaskCommentModel>? comments;
  final List<TaskAttachmentModel>? attachments;
  final List<String>? tags;
  final int? estimatedHours;
  final int? actualHours;
  final String? category;
  final bool? isRecurring;
  final String? recurringPattern;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.status,
    this.priority,
    this.dueDate,
    this.completedAt,
    this.projectId,
    this.projectName,
    this.assignedTo,
    this.assignedToName,
    this.createdBy,
    this.createdByName,
    this.createdAt,
    this.updatedAt,
    this.comments,
    this.attachments,
    this.tags,
    this.estimatedHours,
    this.actualHours,
    this.category,
    this.isRecurring,
    this.recurringPattern,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      priority: json['priority'],
      dueDate: json['dueDate'] != null 
          ? DateTime.parse(json['dueDate']) 
          : null,
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt']) 
          : null,
      projectId: json['projectId'],
      projectName: json['projectName'],
      assignedTo: json['assignedTo'],
      assignedToName: json['assignedToName'],
      createdBy: json['createdBy'],
      createdByName: json['createdByName'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
      comments: json['comments'] != null 
          ? List<TaskCommentModel>.from(json['comments'].map((x) => TaskCommentModel.fromJson(x)))
          : null,
      attachments: json['attachments'] != null 
          ? List<TaskAttachmentModel>.from(json['attachments'].map((x) => TaskAttachmentModel.fromJson(x)))
          : null,
      tags: json['tags'] != null 
          ? List<String>.from(json['tags'])
          : null,
      estimatedHours: json['estimatedHours'],
      actualHours: json['actualHours'],
      category: json['category'],
      isRecurring: json['isRecurring'],
      recurringPattern: json['recurringPattern'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
      'dueDate': dueDate?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'projectId': projectId,
      'projectName': projectName,
      'assignedTo': assignedTo,
      'assignedToName': assignedToName,
      'createdBy': createdBy,
      'createdByName': createdByName,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'comments': comments?.map((x) => x.toJson()).toList(),
      'attachments': attachments?.map((x) => x.toJson()).toList(),
      'tags': tags,
      'estimatedHours': estimatedHours,
      'actualHours': actualHours,
      'category': category,
      'isRecurring': isRecurring,
      'recurringPattern': recurringPattern,
    };
  }

  bool get isCompleted => status == 'completed';
  bool get isInProgress => status == 'in_progress';
  bool get isPending => status == 'pending';
  bool get isOverdue => dueDate != null && dueDate!.isBefore(DateTime.now()) && !isCompleted;
  bool get isHighPriority => priority == 'high';
  bool get isMediumPriority => priority == 'medium';
  bool get isLowPriority => priority == 'low';

  String get statusDisplay {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'in_progress':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  String get priorityDisplay {
    switch (priority) {
      case 'high':
        return 'High';
      case 'medium':
        return 'Medium';
      case 'low':
        return 'Low';
      default:
        return 'Normal';
    }
  }

  int get daysUntilDue {
    if (dueDate == null) return -1;
    final now = DateTime.now();
    final due = DateTime(dueDate!.year, dueDate!.month, dueDate!.day);
    final today = DateTime(now.year, now.month, now.day);
    return due.difference(today).inDays;
  }

  @override
  String toString() {
    return 'TaskModel{id: $id, title: $title, status: $status, priority: $priority}';
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    String? status,
    String? priority,
    DateTime? dueDate,
    DateTime? completedAt,
    int? projectId,
    String? projectName,
    int? assignedTo,
    String? assignedToName,
    int? createdBy,
    String? createdByName,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TaskCommentModel>? comments,
    List<TaskAttachmentModel>? attachments,
    List<String>? tags,
    int? estimatedHours,
    int? actualHours,
    String? category,
    bool? isRecurring,
    String? recurringPattern,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      completedAt: completedAt ?? this.completedAt,
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedToName: assignedToName ?? this.assignedToName,
      createdBy: createdBy ?? this.createdBy,
      createdByName: createdByName ?? this.createdByName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      comments: comments ?? this.comments,
      attachments: attachments ?? this.attachments,
      tags: tags ?? this.tags,
      estimatedHours: estimatedHours ?? this.estimatedHours,
      actualHours: actualHours ?? this.actualHours,
      category: category ?? this.category,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringPattern: recurringPattern ?? this.recurringPattern,
    );
  }
}

class TaskCommentModel {
  final int? id;
  final String? content;
  final int? taskId;
  final int? userId;
  final String? userName;
  final DateTime? createdAt;

  TaskCommentModel({
    this.id,
    this.content,
    this.taskId,
    this.userId,
    this.userName,
    this.createdAt,
  });

  factory TaskCommentModel.fromJson(Map<String, dynamic> json) {
    return TaskCommentModel(
      id: json['id'],
      content: json['content'],
      taskId: json['taskId'],
      userId: json['userId'],
      userName: json['userName'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'taskId': taskId,
      'userId': userId,
      'userName': userName,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}

class TaskAttachmentModel {
  final int? id;
  final String? fileName;
  final String? fileUrl;
  final String? fileType;
  final int? fileSize;
  final int? taskId;
  final int? uploadedBy;
  final String? uploadedByName;
  final DateTime? uploadedAt;

  TaskAttachmentModel({
    this.id,
    this.fileName,
    this.fileUrl,
    this.fileType,
    this.fileSize,
    this.taskId,
    this.uploadedBy,
    this.uploadedByName,
    this.uploadedAt,
  });

  factory TaskAttachmentModel.fromJson(Map<String, dynamic> json) {
    return TaskAttachmentModel(
      id: json['id'],
      fileName: json['fileName'],
      fileUrl: json['fileUrl'],
      fileType: json['fileType'],
      fileSize: json['fileSize'],
      taskId: json['taskId'],
      uploadedBy: json['uploadedBy'],
      uploadedByName: json['uploadedByName'],
      uploadedAt: json['uploadedAt'] != null 
          ? DateTime.parse(json['uploadedAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'fileSize': fileSize,
      'taskId': taskId,
      'uploadedBy': uploadedBy,
      'uploadedByName': uploadedByName,
      'uploadedAt': uploadedAt?.toIso8601String(),
    };
  }
}