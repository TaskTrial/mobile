import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
class ProjectController extends GetxController{
  final projectNameController = TextEditingController();
  final projectDescriptionController = TextEditingController();
  final projectStartDateController = TextEditingController();
  final projectEndDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Project> projects = [
    Project(
      id: "1",
      title: "Fintech Mobile App UI",
      date: "20 July",
      description: "Fintech app development provides more freedom to banking and other financial institutions.",
      progressHours: 70,
      tasksIDs: ["1", "2" ,'3'],
      backgroundColor: Constants.projectCardColor1,
    ),
    Project(
      id: "2",
      title: "Chrome Heart",
      date:  "20 July",
      description: "GreenSky DG focuses on evaluating and developing solar opportunities for landholders",
      progressHours: 20,
      tasksIDs: [ "4" , '5' , '6'],
      backgroundColor:Constants.projectCardColor2,
    ),
    Project(
      id: "3",
      title: "Unsaid Events",
      date: "2023-10-02",
      description: "Fintech app development provides more freedom to banking and other financial institutions.",
      progressHours: 90,
      tasksIDs: ["7", "8" , '9'],
      backgroundColor:Constants.projectCardColor3,
    ),
    Project(
      id: "4",
      title: "Fintech app development",
      date: "2023-10-02",
      description: "Fintech app development provides more freedom to banking and other financial institutions.",
      progressHours: 15,
      tasksIDs: ["7", "8" ,'9'],
      backgroundColor:Constants.projectCardColor4,
    ),
  ];


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    projectNameController.dispose();
    projectDescriptionController.dispose();
    projectStartDateController.dispose();
    projectEndDateController.dispose();
    super.onClose();
  }


}
class Project {
  final String id;
  final String title;
  final String date;
  final String description;
  final int progressHours;
  final List<String> tasksIDs;
  final Color backgroundColor;

  Project({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.progressHours,
    required this.tasksIDs,
    required this.backgroundColor,
  });
}