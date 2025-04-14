import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/services/auth_service.dart';
import 'package:task_trial/views/auth/verify_screen.dart';

import '../../utils/constants.dart';

class SignUpController extends GetxController {
  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;
  final isPasswordVisible = true.obs;
  final isConfirmPasswordVisible = true.obs;
  final rememberMe = false.obs;
  final formKey = GlobalKey<FormState>();
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
  bool toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
    return rememberMe.value;
  }
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }
  signUp() async {
    SignUpAuthServices.signUp(
        emailController: emailController,
        passwordController: passwordController,
        userNameController: userNameController,
        firstNameController: firstNameController,
        lastNameController: lastNameController,
        isLoading: isLoading);
  }
}
