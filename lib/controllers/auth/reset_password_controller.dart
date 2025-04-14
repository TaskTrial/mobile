import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/services/auth_service.dart';

import '../../utils/constants.dart';
import '../../views/auth/login_screen.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final otpController = TextEditingController();
  String args = Get.arguments;
  resetPassword() async {
    LoginAuthServices.resetPassword(
        newPasswordController: newPasswordController,
        otpController: otpController,
        args: args);
  }
}
