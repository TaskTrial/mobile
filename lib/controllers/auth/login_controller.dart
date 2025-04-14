import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/login_model.dart';
import 'package:task_trial/models/user_model.dart';
import 'package:task_trial/services/auth_service.dart';
import 'package:task_trial/utils/cache_helper.dart';

import 'package:task_trial/utils/constants.dart';

import '../../views/auth/login_screen.dart';
import '../../views/auth/reset_password_screen.dart';
import '../../views/main_view_screen.dart';

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

// Add interceptors

  // @override void onClose() {
  //   passwordController.dispose();
  //   super.onClose();
  // }

  bool toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
    return rememberMe.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  login() async {
    AuthService.login(
        emailController: emailController,
        passwordController: passwordController,
        isLoading: isLoading);
  }

  sendOTP() async {
    try {
      final response = await Dio().post(
        'http://192.168.1.5:3000/api/auth/forgotPassword',
        data: {
          'email': emailController.text,
        },
      );
      print(response);
      Get.snackbar('Success', 'OTP sent to ${emailController.text}');
      Get.to(() => ResetPasswordScreen(), arguments: emailController.text);
    } on DioException catch (e) {
      isLoading.value = false;
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          Get.snackbar('Error', 'Connection timeout');
          break;
        case DioExceptionType.receiveTimeout:
          Get.snackbar('Error', 'Receive timeout');
          break;
        case DioExceptionType.sendTimeout:
          Get.snackbar('Error', 'Send timeout');
          break;
        case DioExceptionType.badResponse:
          {
            Get.snackbar(
                'Error', 'Bad response: ${e.response!.data['message ']}',
                backgroundColor: Constants.backgroundColor,
                titleText: const Text(
                  'Error',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: Constants.primaryFont,
                  ),
                ),
                messageText: Text('${e.response!.data['message']}',
                    style: const TextStyle()));
          }
          break;
        case DioExceptionType.badCertificate:
          Get.snackbar('Error', 'Bad certificate');
          break;
        case DioExceptionType.cancel:
          Get.snackbar('Error', 'Request cancelled');
          throw UnimplementedError();
        case DioExceptionType.connectionError:
          Get.snackbar('Error', 'Connection error');
          throw UnimplementedError();
        case DioExceptionType.unknown:
          Get.snackbar('Error', 'Unexpected error: ${e.message}');
          throw UnimplementedError();
      }
    }
  }
}
