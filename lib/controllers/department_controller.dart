import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task_trial/utils/constants.dart';

import '../utils/cache_helper.dart';
import '../views/main_view_screen.dart';
import 'main_view_controller.dart';
class DepartmentController extends GetxController{

  IconData getIconForDepartment(String name) {
    switch (name.toLowerCase()) {
      case 'design':
        return Icons.edit;
      case 'development':
        return Icons.code;
      case 'marketing':
        return Icons.campaign;
      case 'sales':
        return Icons.show_chart;
      default:
        return Icons.business;
    }
  }
  Color getColorForDepartment(String name) {
    switch (name.toLowerCase()) {
      case 'design':
        return const Color(0xFFFFC1B3);
      case 'development':
        return const Color(0xFFFFD3B3);
      case 'marketing':
        return const Color(0xFFFFE1AD);
      case 'sales':
        return const Color(0xFFCDEACE);

      default:
        return Constants.primaryColor.withOpacity(0.4);
    }
  }

  Future<void> updateDepartmentData({required String deptId,required String name,required String description})async{
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
  Future<void> deleteDepartmentData({required String deptId})async{
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
