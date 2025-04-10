import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  bool toggleRememberMe() {

    rememberMe.value = !rememberMe.value;
    return rememberMe.value;

  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      Get.snackbar('Error', 'Email cannot be empty');
    } else if (!GetUtils.isEmail(value)) {
      Get.snackbar('Error', 'Invalid email format');
    }
  }
  void validatePassword(String value) {
    if (value.isEmpty) {
      Get.snackbar('Error', 'Password cannot be empty');
    } else if (value.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
    }
  }
  void validateForm() {
    if (formKey.currentState!.validate()) {
      Get.snackbar('Success', 'Form is valid');
    } else {
      Get.snackbar('Error', 'Form is invalid');
    }
  }
  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }
  void submitForm() {
    if (formKey.currentState!.validate()) {
      Get.snackbar('Success', 'Form submitted successfully');
    } else {
      Get.snackbar('Error', 'Please fill in all fields correctly');
    }
  }
  void resetPassword() {
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }
    isLoading.value = true;
    // Simulate a network request
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar('Success', 'Password reset link sent to ${emailController.text}');
    });
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  signUp() async{
    try {
      // print('email: ${emailController.text} password: ${passwordController.text}  userName: ${userNameController.text} firstName: ${firstNameController.text} lastName: ${lastNameController.text}');
      isLoading.value = true;
      final response = await Dio().post(
        'http://192.168.1.5:3000/api/auth/signup',
        data: {
          'email': emailController.text,
          'password': passwordController.text,
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "username": userNameController.text,
        },
      );
      print(response);
      // SignUpModel signUpModel = SignUpModel.fromJson(response.data);
      // print(signUpModel.user!.toJson());
      isLoading.value = false;
      Get.offAll(() =>  VerifyScreen(),
        arguments: {
          'email': emailController.text,
        },
      );
    } on DioException catch (e) {
      isLoading.value = false;
     print(e);
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
              'Error', 'Bad response: ${e.response!.data['message']}'
              , backgroundColor: Constants.backgroundColor,
              titleText: const Text(
                'Error',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constants.primaryFont,
                ),
              ),
              messageText: Text(
                '${e.response!.data['message']}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: Constants.primaryFont,
                ),
              ),
            );
          }
          break;
        case DioExceptionType.cancel:
          Get.snackbar('Error', 'Request cancelled');
          break;
        case DioExceptionType.unknown:
          Get.snackbar('Error', 'Unexpected error: ${e.message}');
        case DioExceptionType.badCertificate:
          Get.snackbar('Error', 'Bad certificate');
          break;
        case DioExceptionType.connectionError:
          Get.snackbar('Error', 'Connection error');
          break;
      }
    }
  }
}