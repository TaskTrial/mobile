import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../utils/cache_helper.dart';
import '../utils/constants.dart';
import '../views/main_view_screen.dart';
import 'main_view_controller.dart';
class TeamController extends GetxController{
  final name = ''.obs;
  final isLoading = false.obs;
  final Dio _dio = Dio();
  Future<void> createTeam(String organizationId) async {
    if (name.value.isEmpty ) {
      Constants.errorSnackBar(title: 'Error', message: 'Please fill in all fields');
      return;
    }
    isLoading.value = true;
    print('http://192.168.1.5:3000/api/organization/$organizationId/team');
    try {
      final response = await _dio.post(
        'http://192.168.1.5:3000/api/organization/$organizationId/team',
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
}