class UserModel {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? role;
  final String? avatar;
  final int? organizationId;
  final String? organizationName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.avatar,
    this.organizationId,
    this.organizationName,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: json['role'],
      avatar: json['avatar'],
      organizationId: json['organizationId'],
      organizationName: json['organizationName'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'avatar': avatar,
      'organizationId': organizationId,
      'organizationName': organizationName,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  String get fullName {
    final firstName = this.firstName ?? '';
    final lastName = this.lastName ?? '';
    return '$firstName $lastName'.trim();
  }

  String get displayName {
    return fullName.isNotEmpty ? fullName : (email ?? 'Unknown User');
  }

  bool get hasOrganization => organizationId != null;

  @override
  String toString() {
    return 'UserModel{id: $id, email: $email, fullName: $fullName, role: $role, organizationId: $organizationId}';
  }

  UserModel copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
    String? avatar,
    int? organizationId,
    String? organizationName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      organizationId: organizationId ?? this.organizationId,
      organizationName: organizationName ?? this.organizationName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}