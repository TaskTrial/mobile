import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task_trial/utils/constants.dart';
class DepartmentController extends GetxController{

  final List<Department> departments = const [
    Department(
      name: 'Design',
      description: 'Responsible for creating visual assets',
      tasks: 5,
      members: [
        'https://i.pravatar.cc/150?img=1',
        'https://i.pravatar.cc/150?img=2',
        'https://i.pravatar.cc/150?img=3',
      ],
    ),
    Department(
      name: 'Development',
      description: 'Builds and maintains the software product',
      tasks: 8,
      members: [
        'https://i.pravatar.cc/150?img=4',
        'https://i.pravatar.cc/150?img=5',
        'https://i.pravatar.cc/150?img=6',
      ],
    ),
    Department(
      name: 'Marketing',
      description: 'Manages product promotion campaigns',
      tasks: 12,
      members: [
        'https://i.pravatar.cc/150?img=7',
        'https://i.pravatar.cc/150?img=8',
        'https://i.pravatar.cc/150?img=9',
      ],
    ),
    Department(
      name: 'Sales',
      description: 'Handles customer relations and sales',
      tasks: 6,
      members: [
        'https://i.pravatar.cc/150?img=10',
        'https://i.pravatar.cc/150?img=11',
        'https://i.pravatar.cc/150?img=12',
      ],
    ),
    Department(
      name: 'Department',
      description: 'Handles customer relations and sales',
      tasks: 6,
      members: [
      ],
    ),
  ];
  IconData getIconForDepartment(String name) {
    switch (name.toLowerCase()) {
      case 'design':
        return Icons.edit;
      case 'development':
        return Icons.code;
      case 'marketing':
        return Icons.campaign;
      case 'sales':
        return Icons.show_chart;
      default:
        return Icons.business;
    }
  }
  Color getColorForDepartment(String name) {
    switch (name.toLowerCase()) {
      case 'design':
        return const Color(0xFFFFC1B3);
      case 'development':
        return const Color(0xFFFFD3B3);
      case 'marketing':
        return const Color(0xFFFFE1AD);
      case 'sales':
        return const Color(0xFFCDEACE);

      default:
        return Constants.primaryColor.withOpacity(0.4);
    }
  }
}
class Department {
  final String name;
  final String description;
  final int tasks;
  final List<String> members;

  const Department({
    required this.name,
    required this.description,
    required this.tasks,
    required this.members,
  });
}