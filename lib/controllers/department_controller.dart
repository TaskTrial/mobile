
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task_trial/services/department_services.dart';
import 'package:task_trial/utils/constants.dart';

class DepartmentController extends GetxController{

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

  Future<void> updateDepartmentData({required String deptId,required String name,required String description})async{
     DepartmentServices.updateDepartmentData(deptId: deptId, name: name, description: description);
  }
  Future<void> deleteDepartmentData({required String deptId})async{
 DepartmentServices.deleteDepartmentData(deptId: deptId);
  }



}
