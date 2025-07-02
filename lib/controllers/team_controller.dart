
import 'dart:io';

import 'package:dio/dio.dart' as dio;

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/cache_helper.dart';
import '../utils/constants.dart';
import '../views/main_view_screen.dart';
import 'main_view_controller.dart';
class TeamController extends GetxController{
  final name = ''.obs;
  final isLoading = false.obs;
  final Dio _dio = Dio();
  XFile? teamAvatar;

  uploadLogoImage(XFile image) {
    teamAvatar = image;
    update();
  }

  deleteLogoImage(XFile image) {
    teamAvatar = null;
    update();
  }

  Future<void> createTeam(String organizationId) async {
    if (name.value.isEmpty ) {
      Constants.errorSnackBar(title: 'Error', message: 'Please fill in all fields');
      return;
    }
    isLoading.value = true;
    print('https://tasktrial-prod.vercel.app/api/organization/$organizationId/team');
    try {
      final response = await _dio.post(
        'https://tasktrial-prod.vercel.app/api/organization/$organizationId/team',
        data: {
          "name": name.value,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer ${CacheHelper().getData(key: 'accessToken')}',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Constants.successSnackBar(title: 'Success', message: 'Team created successfully');
        Get.delete<MainViewController>();
        Get.offAll(
              () => MainViewScreen(),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 300),
        );
      } else {
        Constants.errorSnackBar(title: 'Error',message: 'Failed to create team');
      }
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTeamData({required String teamId,required String name,required String description})async{
    String orgId = CacheHelper().getData(key: 'orgId');
    try {
      final response = await Dio().put(
          'https://tasktrial-prod.vercel.app/api/organization/$orgId/team/$teamId',
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
          title: 'Success', message: 'Team Updated Successfully !');
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
  Future<void> deleteTeamData({required String teamId})async{
    String orgId = CacheHelper().getData(key: 'orgId');
    try {
      final response = await Dio().delete(
        'https://tasktrial-prod.vercel.app/api/organization/$orgId/team/$teamId',
        options: Options(
          headers: {
            'authorization':
            'Bearer ${CacheHelper().getData(key: 'accessToken')}',
          },
        ),
      );
      Constants.successSnackBar(
          title: 'Success', message: 'Team Deleted Successfully !');
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

   Future<void> updateTeamAvatar({required teamId}) async {
    File imageFile = File(teamAvatar!.path);
    String organizationId = CacheHelper().getData(key: 'orgId');
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'image': await dio.MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });
      var response = await Dio().post(
        'https://tasktrial-prod.vercel.app/api/organization/$organizationId/team/$teamId/avatar/upload',
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
          title: ' Success', message: ' Team avatar Updated Successfully !');
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


   void _handleError(DioException e){
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