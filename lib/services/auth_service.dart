import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/login_model.dart';
import '../utils/cache_helper.dart';
import '../utils/constants.dart';
import '../views/main_view_screen.dart';

class AuthService {
  // login({required  RxBool isLoading,required TextEditingController emailController,required TextEditingController passwordController }) async{
  //   try {
  //     isLoading.value = true;
  //     final response = await Dio().post(
  //       'http://192.168.1.5:3000/api/auth/signin',
  //       data: {
  //         'email': emailController.text,
  //         'password': passwordController.text,
  //       },
  //     );
  //     print(response);
  //     LoginModel loginModel = LoginModel();
  //     loginModel = LoginModel.fromJson(response.data);
  //     print(loginModel.toJson());
  //     isLoading.value = false;
  //     CacheHelper().saveData(key: 'id', value: '${loginModel.user!.id}');
  //     CacheHelper().saveData(key: 'accessToken', value: '${loginModel.accessToken}');
  //     CacheHelper().saveData(key: 'refreshToken', value: '${loginModel.refreshToken}');
  //     isLoading.value = false;
  //     Get.offAll(() =>  MainViewScreen(),
  //     );
  //   } on DioException catch (e) {
  //     isLoading.value = false;
  //     switch (e.type) {
  //       case DioExceptionType.connectionTimeout:
  //         Get.snackbar('Error', 'Connection timeout');
  //         break;
  //       case DioExceptionType.receiveTimeout:
  //         Get.snackbar('Error', 'Receive timeout');
  //         break;
  //       case DioExceptionType.sendTimeout:
  //         Get.snackbar('Error', 'Send timeout');
  //         break;
  //       case DioExceptionType.badResponse:
  //         {
  //           Get.snackbar(
  //             'Error', 'Bad response: ${e.response!.data['message']}'
  //             , backgroundColor: Constants.backgroundColor,
  //             titleText: const Text(
  //               'Error',
  //               style: TextStyle(
  //                 color: Colors.red,
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //                 fontFamily: Constants.primaryFont,
  //               ),
  //             ),
  //             messageText: Text(
  //               '${e.response!.data['message']}',
  //               style: const TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 16,
  //                 fontFamily: Constants.primaryFont,
  //               ),
  //             ),
  //
  //           );
  //         }
  //         break;
  //       case DioExceptionType.cancel:
  //         Get.snackbar('Error', 'Request cancelled');
  //         break;
  //       case DioExceptionType.unknown:
  //         Get.snackbar('Error', 'Unexpected error: ${e.message}');
  //       case DioExceptionType.badCertificate:
  //         Get.snackbar('Error', 'Bad certificate');
  //         break;
  //       case DioExceptionType.connectionError:
  //         Get.snackbar('Error', 'Connection error');
  //         break;
  //     }
  //   }
  // }
}