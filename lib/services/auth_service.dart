import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/login_model.dart';
import '../utils/cache_helper.dart';
import '../utils/constants.dart';
import '../views/main_view_screen.dart';

class AuthService {
  static Future<void> login({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required RxBool isLoading,
  }) async
  {
    try {
      isLoading.value = true;
      final response = await Dio().post(
        'http://192.168.1.5:3000/api/auth/signin',
        data: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );
      print(response);
      LoginModel loginModel = LoginModel();
      loginModel = LoginModel.fromJson(response.data);
      print(loginModel.toJson());
      CacheHelper().saveData(key: 'id', value: '${loginModel.user!.id}');
      CacheHelper()
          .saveData(key: 'accessToken', value: '${loginModel.accessToken}');
      CacheHelper()
          .saveData(key: 'refreshToken', value: '${loginModel.refreshToken}');
      isLoading.value = false;
      Constants.completeSnackBar(
          title: 'Success', message: 'Login Successfully !');
      Get.offAll(
        () => MainViewScreen(),
      );
    } on DioException catch (e) {
      isLoading.value = false;
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          Constants.errorSnackBar(
              title: 'Failed', message: 'Connection timeout');
          break;
        case DioExceptionType.receiveTimeout:
          Constants.errorSnackBar(title: 'Failed', message: 'Receive timeout');
          break;
        case DioExceptionType.sendTimeout:
          Constants.errorSnackBar(title: 'Failed', message: 'Send timeout');
          break;
        case DioExceptionType.badResponse:
          {
            Constants.errorSnackBar(
                title: 'Failed', message: '${e.response!.data['message']}');
          }
          break;
        case DioExceptionType.cancel:
          Constants.errorSnackBar(
              title: 'Failed', message: 'Request cancelled');
          break;
        case DioExceptionType.unknown:
          Constants.errorSnackBar(
              title: 'Error', message: 'Unexpected error: ${e.message}');
          break;
        case DioExceptionType.badCertificate:
          Constants.errorSnackBar(title: 'Failed', message: 'Bad certificate');
          break;
        case DioExceptionType.connectionError:
          Constants.errorSnackBar(title: 'Failed', message: 'Connection error');
          break;
      }
    }
  }


}
