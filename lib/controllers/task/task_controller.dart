import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task {
  final String id;
  final String title;
  final String timeAgo;
  final List<MyUser> assignees;
  final TaskStatus status;

  Task({
    required this.id,
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
      id: "1",
      title: "Landing Page Design",
      timeAgo: "8 hours ago",
      assignees: List.generate(
          7,
              (index) => MyUser(
              id: index.toString(),
              name: 'User $index',
              imageUrl:
              'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index % 100}.jpg')),
      status: TaskStatus.todo,
    ),
    Task(
      id: "2",
      title: "Create New Blog Post",
      timeAgo: "18 hours ago",
      assignees: List.generate(
            10,
            (index) => MyUser(
                id: {index+7}.toString(),
                name: 'User ${index+7}',
                imageUrl:
                    'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index % 100}.jpg'))
      ,
      status: TaskStatus.inProgress,
    ),
    Task(
      id: "3",
      title: "Online Course",
      timeAgo: "2 Days ago",
      assignees: [
        ...List.generate(
            4,
            (index) => MyUser(
                id: {index+7+10}.toString(),
                name: 'User ${index+7+10}',
                imageUrl:
                    'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index % 100}.jpg'))
      ],
      status: TaskStatus.inProgress,
    ),
    Task(
      id: "4",
      title: "Offline Course",
      timeAgo: "3 Days ago",
      assignees: [
        ...List.generate(
            5,
            (index) => MyUser(
                id: {index+7+10+4}.toString(),
                name: 'User ${index+7+10+4}',
                imageUrl:
                    'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index % 100}.jpg'))
      ],
      status: TaskStatus.inProgress,
    ),
    Task(
      id: "5",
      title: "Complete Portfolio",
      timeAgo: "7 Days ago",
      assignees: [
        ...List.generate(
            10,
            (index) => MyUser(
                id: {index+7+10+4+5}.toString(),
                name: 'User ${index+7+10+4+5}',
                imageUrl:
                    'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index % 100}.jpg'))
      ],
      status: TaskStatus.completed,
    ),
    Task(
      id: "6",
      title: "Design New Logo",
      timeAgo: "3 Days ago",
      assignees: [
        ...List.generate(
            3,
            (index) => MyUser(
                id: {index+7+10+4+5+10}.toString(),
                name: 'User ${index+7+10+4+5+10}',
                imageUrl:
                    'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index % 100}.jpg'))
      ],
      status: TaskStatus.todo,
    ),
    Task(
      id: "7",
      title: "Design New Logo",
      timeAgo: "3 Days ago",
      assignees: [
        ...List.generate(
            3,
                (index) => MyUser(
                id: {index+7+10+4+5+10}.toString(),
                name: 'User ${index+7+10+4+5+10}',
                imageUrl:
                'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index % 100}.jpg'))
      ],
      status: TaskStatus.completed,
    ),
    Task(
      id: "8",
      title: "Design New Logo",
      timeAgo: "3 Days ago",
      assignees: [
        ...List.generate(
            3,
                (index) => MyUser(
                id: {index+7+10+4+5+10}.toString(),
                name: 'User ${index+7+10+4+5+10}',
                imageUrl:
                'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index % 100}.jpg'))
      ],
      status: TaskStatus.todo,
    ),
    Task(
      id: "9",
      title: "Design New Logo",
      timeAgo: "3 Days ago",
      assignees: [
        ...List.generate(
            3,
                (index) => MyUser(
                id: {index+7+10+4+5+10}.toString(),
                name: 'User ${index+7+10+4+5+10}',
                imageUrl:
                'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index % 100}.jpg')
        )
      ],
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
  int get todoCount =>
      allTasks.where((t) => t.status == TaskStatus.todo).length;
  int get inProgressCount =>
      allTasks.where((t) => t.status == TaskStatus.inProgress).length;
  int get completedCount =>
      allTasks.where((t) => t.status == TaskStatus.completed).length;
//get task by id
  Task getTaskById(String id) {
    return allTasks.firstWhere((task) => task.id == id);
  }

  // get list of tasks by task ids
  List<Task> getTasksByIds(List<String> ids) {
    List<Task> tasks = [];
    for (String id in ids) {
      Task task = allTasks.firstWhere((task) => task.id == id);
      tasks.add(task);
    }
    return tasks;
  }
  List<String> getUserImagesByTaskIds(List<String> ids) {
    List<String> images = [];
    for (String id in ids) {
      Task task = allTasks.firstWhere((task) => task.id == id);
      images.addAll(task.assignees.map((user) => user.imageUrl).toList());
    }
    return images;
  }
  // get users images by task id
  List<String> getUserImagesByTaskId(String id) {
    Task task = allTasks.firstWhere((task) => task.id == id);
    return task.assignees.map((user) => user.imageUrl).toList();
  }



}



class MyUser {
  String id;
  String name;
  String imageUrl;

  MyUser({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}
