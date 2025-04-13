import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/task_controller.dart';
class  ProjectDetailController  extends GetxController{

  final TaskController taskController = Get.put(TaskController());
  final String projectId;
  ProjectDetailController({required this.projectId});
  List<String> getTaskIdsByProjectId(String projectId) {
    // Replace with your logic to get task IDs by project ID
    return taskController.allTasks.where((task) => task.id == projectId).map((task) => task.id).toList();
  }
  List<String> getUserImagesByTaskIds(List<String> taskIds) {
    List<String> userImages = [];
    for (String taskId in taskIds) {
      userImages.addAll(taskController.getUserImagesByTaskIds([taskId]));
    }
    return userImages;
  }

}