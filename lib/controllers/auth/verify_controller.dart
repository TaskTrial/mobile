
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/services/auth_service.dart';


class VerifyController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
  final isLoading = false.obs;
  final email = Get.arguments['email'] ?? '';
  void verifyCode() {
    if (formKey.currentState!.validate()) {
      SignUpAuthServices.verifyAccount(
          email: email, codeController: codeController, isLoading: isLoading);
      print('Verification code: ${codeController.text}');
    }
  }
}
