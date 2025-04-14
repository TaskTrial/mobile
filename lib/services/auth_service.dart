import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/login_model.dart';
import '../utils/cache_helper.dart';
import '../utils/constants.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/reset_password_screen.dart';
import '../views/auth/verify_screen.dart';
import '../views/main_view_screen.dart';

class LoginAuthServices {
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
      Constants.successSnackBar(
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

  static Future<void> sendOtpToResetPassword({
    required TextEditingController emailController,
    required RxBool isLoading,
  }) async
  {
    try {
      final response = await Dio().post(
        'http://192.168.1.5:3000/api/auth/forgotPassword',
        data: {
          'email': emailController.text,
        },
      );
      print(response);
      Constants.successSnackBar(
          title: 'Success', message: ' OTP sent to ${emailController.text}');
      Get.to(() => ResetPasswordScreen(), arguments: emailController.text);
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

  static Future<void> resetPassword(
      {required TextEditingController newPasswordController,
      required TextEditingController otpController,
      required String args}) async
  {
    try {
      final response = await Dio().post(
        'http://192.168.1.5:3000/api/auth/resetPassword',
        data: {
          "email": args,
          "otp": otpController.text,
          "newPassword": newPasswordController.text
        },
      );
     Constants.successSnackBar(
          title: 'Password reset successfully', message: 'Login to your account to continue');
      Get.offAll(() => LoginScreen());
    } on DioException catch (e) {
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

  static Future<void> loginWithGoogle() async{
    try {
      final response = await Dio().post(
        'http://192.168.1.5:3000/api/auth/google',
      );
     Constants.successSnackBar(
          title: 'Login Success', message: 'Login Success');
      Get.offAll(() => MainViewScreen());
    }
    on DioException catch (e) {
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

class SignUpAuthServices{
  static Future<void> signUp(
      {
        required TextEditingController emailController,
        required TextEditingController passwordController,
        required TextEditingController userNameController,
        required TextEditingController firstNameController,
        required TextEditingController lastNameController,
        required RxBool isLoading,
      }) async
  {
    try {
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
      Constants.alertSnackBar(title: 'Check your email', message: 'We have sent you a verification code to your email');
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

  static Future<void> verifyAccount(
      {
        required String email,
        required TextEditingController codeController,
        required RxBool isLoading,
      }
      ) async
  {
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
      Constants.successSnackBar(
          title: 'Email Verified Successfully', message: 'Please , login to continue');
      isLoading.value = false;
      Get.offAll(() =>  LoginScreen(),
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
