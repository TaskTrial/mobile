import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SignUpController extends GetxController {
  final nameController = TextEditingController();
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

  void login() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }
    isLoading.value = true;
    // Simulate a network request
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      Get.snackbar('Success', 'Logged in successfully');
    });
  }
}