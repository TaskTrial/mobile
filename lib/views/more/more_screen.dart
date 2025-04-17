import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/main_view_controller.dart';
import 'package:task_trial/models/departments_model.dart';
import 'package:task_trial/models/organization_model.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/profile/my_organization_screen.dart';
import 'package:task_trial/widgets/more_button.dart';
class MoreScreen extends StatelessWidget {
  final OrganizationModel organization;
  final DepartmentsModel departments;
  const MoreScreen({super.key, required this.organization, required this.departments});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Constants.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            MoreButton(icon: Icons.account_balance_rounded,label: 'My Organization',
            onTap: () {
              Get.to(() => MyOrganizationScreen(),
                arguments:  organization,
              );
            },
            ),
            SizedBox(height: 20),
            MoreButton(icon: Icons.apartment,label: 'My Departments',),
            SizedBox(height: 20),

            MoreButton(icon: Icons.people_alt,label: 'My Teams',)

          ],
        )
      )
    );
  }
}
