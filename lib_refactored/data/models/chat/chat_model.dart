class ChatModel {
  final int? id;
  final String? title;
  final String? type;
  final int? userId;
  final String? userName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ChatMessageModel>? messages;
  final String? status;
  final Map<String, dynamic>? metadata;

  ChatModel({
    this.id,
    this.title,
    this.type,
    this.userId,
    this.userName,
    this.createdAt,
    this.updatedAt,
    this.messages,
    this.status,
    this.metadata,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      userId: json['userId'],
      userName: json['userName'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
      messages: json['messages'] != null 
          ? List<ChatMessageModel>.from(json['messages'].map((x) => ChatMessageModel.fromJson(x)))
          : null,
      status: json['status'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'userId': userId,
      'userName': userName,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'messages': messages?.map((x) => x.toJson()).toList(),
      'status': status,
      'metadata': metadata,
    };
  }

  bool get isActive => status == 'active';
  bool get isArchived => status == 'archived';
  bool get isAIChat => type == 'ai';
  bool get isTeamChat => type == 'team';
  bool get isProjectChat => type == 'project';

  String get statusDisplay {
    switch (status) {
      case 'active':
        return 'Active';
      case 'archived':
        return 'Archived';
      default:
        return 'Unknown';
    }
  }

  String get typeDisplay {
    switch (type) {
      case 'ai':
        return 'AI Assistant';
      case 'team':
        return 'Team Chat';
      case 'project':
        return 'Project Chat';
      default:
        return 'Chat';
    }
  }

  @override
  String toString() {
    return 'ChatModel{id: $id, title: $title, type: $type, messageCount: ${messages?.length ?? 0}}';
  }

  ChatModel copyWith({
    int? id,
    String? title,
    String? type,
    int? userId,
    String? userName,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ChatMessageModel>? messages,
    String? status,
    Map<String, dynamic>? metadata,
  }) {
    return ChatModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      messages: messages ?? this.messages,
      status: status ?? this.status,
      metadata: metadata ?? this.metadata,
    );
  }
}

class ChatMessageModel {
  final int? id;
  final int? chatId;
  final String? content;
  final String? senderType;
  final int? senderId;
  final String? senderName;
  final String? senderAvatar;
  final DateTime? timestamp;
  final String? messageType;
  final Map<String, dynamic>? metadata;
  final bool? isRead;
  final List<ChatAttachmentModel>? attachments;

  ChatMessageModel({
    this.id,
    this.chatId,
    this.content,
    this.senderType,
    this.senderId,
    this.senderName,
    this.senderAvatar,
    this.timestamp,
    this.messageType,
    this.metadata,
    this.isRead,
    this.attachments,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'],
      chatId: json['chatId'],
      content: json['content'],
      senderType: json['senderType'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      senderAvatar: json['senderAvatar'],
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp']) 
          : null,
      messageType: json['messageType'],
      metadata: json['metadata'],
      isRead: json['isRead'],
      attachments: json['attachments'] != null 
          ? List<ChatAttachmentModel>.from(json['attachments'].map((x) => ChatAttachmentModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'content': content,
      'senderType': senderType,
      'senderId': senderId,
      'senderName': senderName,
      'senderAvatar': senderAvatar,
      'timestamp': timestamp?.toIso8601String(),
      'messageType': messageType,
      'metadata': metadata,
      'isRead': isRead,
      'attachments': attachments?.map((x) => x.toJson()).toList(),
    };
  }

  bool get isFromUser => senderType == 'user';
  bool get isFromAI => senderType == 'ai';
  bool get isFromSystem => senderType == 'system';
  bool get isTextMessage => messageType == 'text';
  bool get isImageMessage => messageType == 'image';
  bool get isFileMessage => messageType == 'file';
  bool get isCodeMessage => messageType == 'code';

  String get senderTypeDisplay {
    switch (senderType) {
      case 'user':
        return 'User';
      case 'ai':
        return 'AI Assistant';
      case 'system':
        return 'System';
      default:
        return 'Unknown';
    }
  }

  String get messageTypeDisplay {
    switch (messageType) {
      case 'text':
        return 'Text';
      case 'image':
        return 'Image';
      case 'file':
        return 'File';
      case 'code':
        return 'Code';
      default:
        return 'Message';
    }
  }

  String get timeAgo {
    if (timestamp == null) return 'Unknown';
    
    final now = DateTime.now();
    final difference = now.difference(timestamp!);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  String toString() {
    return 'ChatMessageModel{id: $id, senderType: $senderType, messageType: $messageType}';
  }
}

class ChatAttachmentModel {
  final int? id;
  final int? messageId;
  final String? fileName;
  final String? fileUrl;
  final String? fileType;
  final int? fileSize;
  final String? thumbnailUrl;
  final DateTime? uploadedAt;

  ChatAttachmentModel({
    this.id,
    this.messageId,
    this.fileName,
    this.fileUrl,
    this.fileType,
    this.fileSize,
    this.thumbnailUrl,
    this.uploadedAt,
  });

  factory ChatAttachmentModel.fromJson(Map<String, dynamic> json) {
    return ChatAttachmentModel(
      id: json['id'],
      messageId: json['messageId'],
      fileName: json['fileName'],
      fileUrl: json['fileUrl'],
      fileType: json['fileType'],
      fileSize: json['fileSize'],
      thumbnailUrl: json['thumbnailUrl'],
      uploadedAt: json['uploadedAt'] != null 
          ? DateTime.parse(json['uploadedAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'messageId': messageId,
      'fileName': fileName,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'fileSize': fileSize,
      'thumbnailUrl': thumbnailUrl,
      'uploadedAt': uploadedAt?.toIso8601String(),
    };
  }

  bool get isImage => fileType?.startsWith('image/') ?? false;
  bool get isDocument => fileType?.startsWith('application/') ?? false;
  bool get isVideo => fileType?.startsWith('video/') ?? false;
  bool get isAudio => fileType?.startsWith('audio/') ?? false;

  String get fileSizeDisplay {
    if (fileSize == null) return 'Unknown size';
    
    if (fileSize! < 1024) {
      return '${fileSize} B';
    } else if (fileSize! < 1024 * 1024) {
      return '${(fileSize! / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(fileSize! / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }
}