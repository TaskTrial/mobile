import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/department/create_department_screen.dart';

class CreateDialog {
  static void showCreateDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Constants.backgroundColor,
        title: Text(
          'Create New',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Constants.pageNameColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOptionTile(Icons.apartment, "Department", () {
             Get.to(()=> CreateDepartmentScreen(organizationId: CacheHelper().getData(key: 'orgId')));
              print("Create Department");
            }),
            _buildOptionTile(Icons.group, "Team", () {
              Get.back();
              // Navigate to your team creation screen
              print("Create Team");
            }),
            _buildOptionTile(Icons.work, "Project", () {
              Get.back();
              // Navigate to your project creation screen
              print("Create Project");
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Constants.primaryColor),
            ),
          )
        ],
      ),
    );
  }

  static Widget _buildOptionTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Constants.primaryColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Constants.pageNameColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
