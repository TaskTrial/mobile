import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main_view_controller.dart';
import '../utils/cache_helper.dart';
import '../utils/constants.dart';
import '../views/main_view_screen.dart';

class EditProfileServices {
  static Future<void> updateProfileImage(File imageFile) async {
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'image': await dio.MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });
      var response = await Dio().post(
        'http://192.168.1.5:3000/api/users/${CacheHelper().getData(key: 'id')}/profile-picture',
        data: formData,
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization':
                'Bearer ${CacheHelper().getData(key: 'accessToken')}',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      print(response.data);
      Constants.successSnackBar(
          title: ' Success', message: ' Profile Image Updated Successfully !');
      Get.delete<MainViewController>();
      Get.offAll(
        () => MainViewScreen(),
        transition: Transition.fade,
        duration: const Duration(milliseconds: 300),
      );
    } on DioException catch (e) {
     _handleError(e);
    }
  }

  static Future<void> updateProfileData(
      {required TextEditingController firstNameController,
      required TextEditingController lastNameController,
      required TextEditingController phoneNumberController,
      required TextEditingController jobTitleController,
      required TextEditingController bioController,
      required String timeZone}) async
  {
    try {
      final response = await Dio().put(
          'http://192.168.1.5:3000/api/users/${CacheHelper().getData(key: 'id')}',
          options: Options(
            headers: {
              'authorization':
                  'Bearer ${CacheHelper().getData(key: 'accessToken')}',
            },
          ),
          data: {
            "firstName": firstNameController.text,
            "lastName": lastNameController.text,
            "phoneNumber": phoneNumberController.text,
            "jobTitle": jobTitleController.text,
            "timezone": timeZone,
            "bio": bioController.text,
            "role": "MEMBER",
            "departmentId": "",
            "organizationId": ""
          });
      Constants.successSnackBar(
          title: 'Success', message: 'Profile Updated Successfully !');
      Get.delete<MainViewController>();
      Get.offAll(
        () => MainViewScreen(),
        transition: Transition.fade,
        duration: const Duration(milliseconds: 300),
      );
    } on DioException catch (e)
    {
    _handleError(e);
    }
  }





 static void _handleError(DioException e){
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
