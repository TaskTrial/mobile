import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/dashboard_controller.dart';
import 'package:task_trial/utils/constants.dart';

class DashboardController extends GetxController {
  List<Map<String, dynamic>> dashboardData = [
    {
      'check': true,
      'task': 'Create a user flow of social application design',
      'status': 'Approved'
    },
    {
      'check': false,
      'task': 'Create a user flow of social application design',
      'status': 'On going'
    },
    {
      'check': true,
      'task': 'Landing page design for Fintech project of singapore',
      'status': 'In review'
    },
    {
      'check': true,
      'task': 'Create a user flow of social application design',
      'status': 'Approved'
    },
    {
      'check': false,
      'task': 'Create a user flow of social application design',
      'status': 'In review'
    },
  ];
  List<Map<String, dynamic>> dashboardProjectsData = [
    {
      'name': 'Nelsa web developement',
      'percentage': 1,
      'status': 'Completed'
    },
    {
      'name': 'Datascale AI app ',
      'percentage': 0.35,
      'status': 'Delayed'
    },
    {
      'name': 'Media channel branding',
      'percentage': 0.68,
      'status': 'At risk'
    },
    {
      'name': 'Website builder developement',
      'percentage': 0.5,
      'status': 'On going'
    },

  ];

  toggleCheck(int index) {
    dashboardData[index]['check'] = !dashboardData[index]['check'];
    update();
  }

  List<Map<String, dynamic>> getDashboardData() {
    return dashboardData;
  }
}
