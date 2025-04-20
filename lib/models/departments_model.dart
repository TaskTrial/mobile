class DepartmentsModel {
  final List<Department>? departments;
  final Pagination? pagination;

  DepartmentsModel({this.departments, this.pagination});
  factory DepartmentsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return DepartmentsModel(
      departments: (data['departments'] as List?)
          ?.map((e) => Department.fromJson(e))
          .toList(),
      pagination: data['pagination'] != null
          ? Pagination.fromJson(data['pagination'])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'departments': departments?.map((e) => e.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}
class Department {
  final String? id;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final Organization? organization;
  final Manager? manager;

  Department({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.organization,
    this.manager,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      organization: json['organization'] != null
          ? Organization.fromJson(json['organization'])
          : null,
      manager: json['manager'] != null
          ? Manager.fromJson(json['manager'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'organization': organization?.toJson(),
      'manager': manager?.toJson(),
    };
  }
}

class Organization {
  final String? id;
  final String? name;

  Organization({this.id, this.name});

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
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

class Manager {
  final String? id;
  final String? firstName;
  final String? lastName;

  Manager({this.id, this.firstName, this.lastName});

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}

class Pagination {
  final int? page;
  final int? limit;
  final int? totalItems;
  final int? totalPages;

  Pagination({this.page, this.limit, this.totalItems, this.totalPages});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      limit: json['limit'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'totalItems': totalItems,
      'totalPages': totalPages,
    };
  }
}
