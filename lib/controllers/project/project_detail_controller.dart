import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/project/project_controller.dart';
import 'package:task_trial/controllers/task/task_controller.dart';
class  ProjectDetailController  extends GetxController{

  final TaskController taskController = Get.put(TaskController());
  final Project project ;
  List<Task> tasks=[] ;
  @override
  void onInit() {
   tasks =taskController.getTasksByIds(project.tasksIDs);
    super.onInit();
  }

  ProjectDetailController({required this.project});
  List<String> getTaskIdsByProjectId(String projectId) {
    return taskController.allTasks.where((task) => task.id == projectId).map((task) => task.id).toList();
  }


  List<Task> getTasksByTaskIds(List<String> taskIds) {
    List<Task> tasks = [];
    for (String taskId in taskIds) {
      tasks.add(taskController.getTaskById(taskId));
    }
    return tasks;
  }
  // get user images by task id
  List<String> getUserImagesByTaskId(String taskId) {
    return taskController.getUserImagesByTaskId(taskId);
  }



}