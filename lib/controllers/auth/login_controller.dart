import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/services/auth_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final isLoading = false.obs;
  final isPasswordVisible = true.obs;
  final rememberMe = false.obs;
  final formKey = GlobalKey<FormState>();

  final otpController = TextEditingController();

  final isSignedIn = false.obs;
  final dio = Dio();
  bool toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
    return rememberMe.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  login() async {
    LoginAuthServices.login(
        emailController: emailController,
        passwordController: passwordController,
        isLoading: isLoading);
  }

  sendOTP() async {
    LoginAuthServices.sendOtpToResetPassword(
        emailController: emailController, isLoading: isLoading);
  }
  loginWithGoogle(){
    LoginAuthServices.loginWithGoogle();
  }
}
