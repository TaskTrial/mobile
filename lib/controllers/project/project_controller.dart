import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
class ProjectController extends GetxController{
  final projectNameController = TextEditingController();
  final projectDescriptionController = TextEditingController();
  final projectStartDateController = TextEditingController();
  final projectEndDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<Map<String,dynamic>> projectList = [
    {
      'title': 'Fintech Mobile App UI',
      'date': '20 July',
      'description':
      'Fintech app development provides more freedom to banking and other financial institutions.',
      'progressHours': 91,
      'teamImages': [
        'https://randomuser.me/api/portraits/women/1.jpg',
        'https://randomuser.me/api/portraits/men/2.jpg',
        'https://randomuser.me/api/portraits/women/3.jpg',
        'https://randomuser.me/api/portraits/men/4.jpg',
        'https://randomuser.me/api/portraits/women/5.jpg',
      ],
      'backgroundColor': Constants.getRandomProjectCardColor(),
    },
    {
      'title': 'Green sky Website Dev',
      'date': '12 June',
      'description':
      'GreenSky DG focuses on evaluating and developing solar opportunities for landholders',
      'progressHours': 15,
      'teamImages': [
        'https://randomuser.me/api/portraits/women/1.jpg',
        'https://randomuser.me/api/portraits/men/2.jpg',
        'https://randomuser.me/api/portraits/women/3.jpg',
        'https://randomuser.me/api/portraits/men/4.jpg',
        'https://randomuser.me/api/portraits/women/5.jpg',
      ],
      'backgroundColor': Constants.getRandomProjectCardColor(),
    },
    {
      'title': 'Fintech Mobile App UI',
      'date': '20 July',
      'description':
      'Fintech app development provides more freedom to banking and other financial institutions.',
      'progressHours': 91,
      'teamImages': [
        'https://randomuser.me/api/portraits/women/7.jpg',
        'https://randomuser.me/api/portraits/men/2.jpg',
        'https://randomuser.me/api/portraits/women/3.jpg',
        'https://randomuser.me/api/portraits/men/4.jpg',
        'https://randomuser.me/api/portraits/women/5.jpg',
      ],
      'backgroundColor': Constants.getRandomProjectCardColor(),
    }
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