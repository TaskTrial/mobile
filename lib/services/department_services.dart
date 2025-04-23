
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../controllers/main_view_controller.dart';
import '../utils/cache_helper.dart';
import '../utils/constants.dart';
import '../views/main_view_screen.dart';

class DepartmentServices {

 static Future<void> createDepartment({required String organizationId, required RxString name, required RxString description, required RxBool isLoading}) async {
   final Dio dio = Dio();
    if (name.value.isEmpty || description.value.isEmpty) {
      Constants.errorSnackBar(title: 'Error', message: 'Please fill in all fields');
      return;
    }
    isLoading.value = true;
    print('http://192.168.1.5:3000/organizations/$organizationId/departments/create');
    try {
      final response = await dio.post(
        'http://192.168.1.5:3000/api/organizations/$organizationId/departments/create',
        data: {
          "name": name.value,
          "description": description.value,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer ${CacheHelper().getData(key: 'accessToken')}',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Constants.successSnackBar(title: 'Success', message: 'Department created successfully');
        Get.delete<MainViewController>();
        Get.offAll(
              () => MainViewScreen(),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 300),
        );
      } else {
        Constants.errorSnackBar(title: 'Error',message: 'Failed to create department');
      }
    }on DioException catch (e) {
       _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }
 static Future<void> updateDepartmentData({required String deptId,required String name,required String description})async{
    String orgId = CacheHelper().getData(key: 'orgId');
    try {
      final response = await Dio().put(
          'http://192.168.1.5:3000/api/organizations/$orgId/departments/$deptId',
          options: Options(
            headers: {
              'authorization':
              'Bearer ${CacheHelper().getData(key: 'accessToken')}',
            },
          ),
          data: {
            "name": name ,
            "description": description,
          });
      Constants.successSnackBar(
          title: 'Success', message: 'Department Updated Successfully !');
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
 static Future<void> deleteDepartmentData({required String deptId})async{
    String orgId = CacheHelper().getData(key: 'orgId');
    try {
      final response = await Dio().delete(
        'http://192.168.1.5:3000/api/organizations/$orgId/departments/$deptId/delete',
        options: Options(
          headers: {
            'authorization':
            'Bearer ${CacheHelper().getData(key: 'accessToken')}',
          },
        ),
      );
      Constants.successSnackBar(
          title: 'Success', message: 'Department Deleted Successfully !');
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