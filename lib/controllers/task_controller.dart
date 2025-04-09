import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task {
  final String title;
  final String timeAgo;
  final List<String> assignees;
  final TaskStatus status;

  Task({
    required this.title,
    required this.timeAgo,
    required this.assignees,
    required this.status,
  });
}

enum TaskStatus { all, todo, inProgress, completed }
class TaskController extends GetxController {
  final RxInt selectedFilterIndex = 0.obs;

  final List<Task> allTasks = [
    Task(
      title: "Landing Page Design",
      timeAgo: "8 hours ago",
      assignees: ["https://randomuser.me/api/portraits/men/3.jpg", "https://randomuser.me/api/portraits/men/2.jpg"],
      status: TaskStatus.todo,
    ),
    Task(
      title: "Create New Blog Post",
      timeAgo: "18 hours ago",
      assignees: ["https://randomuser.me/api/portraits/men/4.jpg"],
      status: TaskStatus.inProgress,
    ),
    Task(
      title: "Online Course",
      timeAgo: "2 Days ago",
      assignees: ["https://randomuser.me/api/portraits/men/7.jpg"],
      status: TaskStatus.inProgress,
    ),
    Task(
      title: "Offline Course",
      timeAgo: "3 Days ago",
      assignees: ["https://randomuser.me/api/portraits/men/7.jpg"],
      status: TaskStatus.inProgress,
    ),
    Task(
      title: "Complete Portfolio",
      timeAgo: "7 Days ago",
      assignees: ["https://randomuser.me/api/portraits/men/8.jpg"],
      status: TaskStatus.completed,
    ),
    Task(
      title: "Design New Logo",
      timeAgo: "3 Days ago",
      assignees: ["https://randomuser.me/api/portraits/men/8.jpg"],
      status: TaskStatus.todo,
    ),
  ];
  void changeFilter(int index) {
    selectedFilterIndex.value = index;
  }

  List<Task> get filteredTasks {
    if (selectedFilterIndex.value == 0) return allTasks;
    if (selectedFilterIndex.value == 1) {
      return allTasks.where((t) => t.status == TaskStatus.todo).toList();
    } else if (selectedFilterIndex.value == 2) {
      return allTasks.where((t) => t.status == TaskStatus.inProgress).toList();
    } else {
      return allTasks.where((t) => t.status == TaskStatus.completed).toList();
    }
  }

  int get allCount => allTasks.length;
  int get todoCount => allTasks.where((t) => t.status == TaskStatus.todo).length;
  int get inProgressCount => allTasks.where((t) => t.status == TaskStatus.inProgress).length;
  int get completedCount => allTasks.where((t) => t.status == TaskStatus.completed).length;
}
