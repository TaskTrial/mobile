import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
        backgroundColor: Colors.white,
        body: Center(
            child:  Text('TaskTrial' , style: TextStyle(
              fontFamily: Constants.primaryFont,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Constants.pageNameColor,
              letterSpacing: 3,
              wordSpacing: 5,
              height: 3,
              decoration: TextDecoration.none,
              decorationColor: Constants.pageNameColor,
              decorationStyle: TextDecorationStyle.solid,
              decorationThickness: 1.5,
            ))
        )
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
