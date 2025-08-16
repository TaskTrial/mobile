import '../../data/models/auth/user_model.dart' as data;

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

  factory UserModel.fromDataModel(data.UserModel dataModel) {
    return UserModel(
      id: dataModel.id,
      email: dataModel.email,
      firstName: dataModel.firstName,
      lastName: dataModel.lastName,
      role: dataModel.role,
      avatar: dataModel.avatar,
      organizationId: dataModel.organizationId,
      organizationName: dataModel.organizationName,
      createdAt: dataModel.createdAt,
      updatedAt: dataModel.updatedAt,
    );
  }

  data.UserModel toDataModel() {
    return data.UserModel(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      role: role,
      avatar: avatar,
      organizationId: organizationId,
      organizationName: organizationName,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
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