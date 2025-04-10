import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/views/auth/login_screen.dart';
import 'package:task_trial/views/auth/reset_password_screen.dart';
import 'package:task_trial/views/auth/sign_up_screen.dart';
import 'package:task_trial/views/auth/verify_screen.dart';
import 'package:task_trial/views/landing_screen.dart';
import 'package:task_trial/views/main_view_screen.dart';
import 'package:task_trial/views/profile/profile_screen.dart';
import 'package:task_trial/views/task/task_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Trial',
      home:   MainViewScreen(),
    );
  }
}