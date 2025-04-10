import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/views/auth/login_screen.dart';

import '../../utils/constants.dart';
class VerifyController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
  final isLoading = false.obs;
  final email = Get.arguments['email'] ?? '';
  void verifyCode() {
    if (formKey.currentState!.validate()) {
      verify(email: email);
      print('Verification code: ${codeController.text}');
    }
  }
  verify({required String email}) async{
    try {
      isLoading.value = true;
      final response = await Dio().post(
        'http://192.168.1.5:3000/api/auth/verifyEmail',
        data: {
          'email': email,
          'otp': codeController.text,
        },
      );
      print(response);
      Get.snackbar("Please Login", 'Email Verified Successfully',
      titleText: const Text(
        'Please Login',
        style: TextStyle(
          color: Colors.green,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: Constants.primaryFont,
        ),
      ),
      messageText: Text(
        'Email Verified Successfully',
        style: const TextStyle(
          color: Colors.greenAccent,
          fontSize: 16,
          fontFamily: Constants.primaryFont,
        ),
      ),
    );
      isLoading.value = false;
      Get.offAll(() =>  LoginScreen(),
      );
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