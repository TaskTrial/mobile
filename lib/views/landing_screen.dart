import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/dashboard_controller.dart';
import 'package:task_trial/utils/cache_helper.dart';

import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/organization/create_organization_screen.dart';
import 'package:task_trial/views/auth/login_screen.dart';
import 'package:task_trial/views/main_view_screen.dart';
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}
class _LandingScreenState extends State<LandingScreen> {

  @override
  void initState() {
    checkLogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,

      body: Center(
        child: CircularProgressIndicator(
          color: Constants.primaryColor,
        )
      ),
    );
  }
checkLogin() async {
  Future.delayed(Duration(seconds: 1), () async {
    if (await CacheHelper().containsKey(key: 'id')) {
      Get.offAll(
            () => CreateOrganizationScreen(),
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 500),
      );
    } else {
      Get.offAll(
            () => LoginScreen(),
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 500),
      );
    }
  });
  }

}
