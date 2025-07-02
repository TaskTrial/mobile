import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../controllers/main_view_controller.dart';
import '../utils/cache_helper.dart';
import '../utils/constants.dart';
import '../views/main_view_screen.dart';
class ProjectServices {
 static String formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

 static Future<void> removeMember({required String userId ,required String teamId
    ,required String projectId
 })async{
   String orgId = CacheHelper().getData(key: 'orgId');
   print('https://tasktrial-prod.vercel.app/api/organization/$orgId/team/$teamId/project/$projectId/removeMembe');
   try {
     final response = await Dio().delete(
       'https://tasktrial-prod.vercel.app/api/organization/$orgId/team/$teamId/project/$projectId/removeMember',
       options: Options(
         headers: {
           'authorization':
           'Bearer ${CacheHelper().getData(key: 'accessToken')}',
         },
       ),
       data: {
         "userId": userId,
       },
     );
     Constants.successSnackBar(
         title: 'Success', message: 'Member Removed Successfully !');
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

 static Future<void> addMembers({
   required String teamId,
   required String projectId,
   required List<Map<String, String>> userRoles,
 }) async {
   String orgId = CacheHelper().getData(key: 'orgId');
   print(userRoles);
   print('https://tasktrial-prod.vercel.app/api/organization/$orgId/team/$teamId/project/$projectId/addMember');

   try {
     final response = await Dio().post(
       'https://tasktrial-prod.vercel.app/api/organization/$orgId/team/$teamId/project/$projectId/addMember',
       options: Options(
         headers: {
           'authorization': 'Bearer ${CacheHelper().getData(key: 'accessToken')}',
         },
       ),
       data: {
         "members": userRoles,
       },
     );

     Constants.successSnackBar(
         title: 'Success', message: 'Members Added Successfully!');
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
  static Future<void> createProject(
  {
    required TextEditingController nameController,
    required TextEditingController descriptionController,
    required Rx<DateTime> startDate,
    required Rx<DateTime> endDate,
    required RxDouble progress,
    required RxString selectedTeamId,
  }
      ) async
  {
    Dio  dio = Dio();
    final projectData = {
      "name": nameController.text.trim(),
      "description": descriptionController.text.trim(),
      "startDate": formatDate(startDate.value),
      "endDate": formatDate(endDate.value),
      "progress": progress.value.round(),
    };
    String organizationId = CacheHelper().getData(key: 'orgId');
    String teamId =  selectedTeamId.value;
    print('https://tasktrial-prod.vercel.app/organization/$organizationId/team/$teamId/project');
    try {
      final response = await dio.post(
        'https://tasktrial-prod.vercel.app/api/organization/$organizationId/team/$teamId/project',
        data: projectData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${CacheHelper().getData(key: 'accessToken')}',
          },
        ),
      );
      Constants.successSnackBar(title: 'Success', message: 'Project created successfully');
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
static Future<void> deleteProjectData({required String teamId,
   required String projectId,})async
{
   String orgId = CacheHelper().getData(key: 'orgId');
   try {
     final response = await Dio().delete(
       'https://tasktrial-prod.vercel.app/api/organization/$orgId/team/$teamId/project/$projectId/delete',
       options: Options(
         headers: {
           'authorization':
           'Bearer ${CacheHelper().getData(key: 'accessToken')}',
         },
       ),
     );
     Constants.successSnackBar(
         title: 'Success', message: 'Project Deleted Successfully !');
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
 static Future<void> updateProjectData({
   required String teamId,
   required String projectId,
   required Map<String, dynamic> data,
   required RxBool isLoading,
 }) async {
   isLoading.value = true;
   final orgId = CacheHelper().getData(key: 'orgId');
   try {
     final response = await Dio().put(
       'https://tasktrial-prod.vercel.app/api/organization/$orgId/team/$teamId/project/$projectId',
       options: Options(
         headers: {
           'authorization':
           'Bearer ${CacheHelper().getData(key: 'accessToken')}',
         },
       ),
       data: data,
     );
     Constants.successSnackBar(
       title: 'Success',
       message: 'Project Updated Successfully!',
     );
     Get.delete<MainViewController>();
     Get.offAll(() => MainViewScreen());
   } on DioException catch (e) {
     _handleError(e);
   } finally {
     isLoading.value = false;
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