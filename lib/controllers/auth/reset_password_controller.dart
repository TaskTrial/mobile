import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../views/auth/login_screen.dart';
class ResetPasswordController  extends GetxController{
  final newPasswordController = TextEditingController();
  final otpController = TextEditingController();
  String args = Get.arguments;
  resetPassword() async{
    try {
      print('reset');
      print(args);
      final response = await Dio().post(
        'http://192.168.1.5:3000/api/auth/resetPassword',
        data: {
          "email": args,
          "otp": otpController.text,
          "newPassword": newPasswordController.text
        },
      );
      print(response);
      Get.snackbar('Success', 'Password reset successfully');
      Get.offAll(() => LoginScreen());
    } on DioException catch (e) {
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