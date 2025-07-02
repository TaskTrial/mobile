import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main_view_controller.dart';
import '../utils/cache_helper.dart';
import '../utils/constants.dart';
import '../views/main_view_screen.dart';
class OrganizationServices {
  static Future<void> updateLogoImage(File imageFile, String organizationId) async {
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'image': await dio.MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });
      var response = await Dio().post(
        'https://tasktrial-prod.vercel.app/api/organization/$organizationId/logo/upload',
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
          title: ' Success', message: ' Logo Image Updated Successfully !');
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

  static Future<void> updateOrganizationData(
      {
        required String orgId,
        required TextEditingController nameController,
        required TextEditingController descriptionController,
        required TextEditingController phoneNumberController,
        required TextEditingController emailController,
        required TextEditingController addressController,
        required TextEditingController websiteController,
        required TextEditingController industryController,
        required TextEditingController sizeRangeController,
        required TextEditingController logoUrlController,
      }) async
  {
    try {
      print('https://tasktrial-prod.vercel.app/api/organization/$orgId');
      final response = await Dio().put(
          'https://tasktrial-prod.vercel.app/api/organization/$orgId',
          options: Options(
            headers: {
              'authorization':
              'Bearer ${CacheHelper().getData(key: 'accessToken')}',
            },
          ),
          data: {
            "name": nameController.text ,
            "description": descriptionController.text,
            "industry": industryController.text,
            "sizeRange": sizeRangeController.text,
            "website": websiteController.text,
            "logoUrl": logoUrlController.text,
            "address":  addressController.text ,
            "contactEmail": emailController.text,
            "contactPhone": phoneNumberController.text
          });
      Constants.successSnackBar(
          title: 'Success', message: 'Organization Updated Successfully !');
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
  static Future<void> addOwner({required userId})async{
    String orgId = CacheHelper().getData(key: 'orgId');
    List<String> userIds = [userId];
    try {
      final response = await Dio().post(
          'https://tasktrial-prod.vercel.app/api/organization/$orgId/addOwner',
          options: Options(
            headers: {
              'authorization':
              'Bearer ${CacheHelper().getData(key: 'accessToken')}',
            },
          ),
          data: {
            "userIds": userIds,
          });
      Constants.successSnackBar(
          title: 'Success', message: 'Owner Added Successfully !');
      Get.delete<MainViewController>();
      Get.offAll(
            () => MainViewScreen(),
        transition: Transition.fade,
        duration: const Duration(milliseconds: 300),
      );
    }
    on DioException catch (e)
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
          print('${e.response!.data['message']}');
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