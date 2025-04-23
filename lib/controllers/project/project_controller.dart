import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../utils/cache_helper.dart';
import '../../utils/constants.dart';
import '../../views/main_view_screen.dart';
import '../main_view_controller.dart';

class ProjectController extends GetxController {
  var isLoading = false.obs;
  Future<void> updateProjectData({
    required String teamId,
    required String projectId,
    required Map<String, dynamic> data,
  }) async {
    isLoading.value = true;
    final orgId = CacheHelper().getData(key: 'orgId');
    try {
      final response = await Dio().put(
        'http://192.168.1.5:3000/api/organization/$orgId/team/$teamId/project/$projectId',
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
  Future<void> deleteProjectData({required String teamId,
    required String projectId,})async{
    String orgId = CacheHelper().getData(key: 'orgId');
    try {
      final response = await Dio().delete(
        'http://192.168.1.5:3000/api/organization/$orgId/team/$teamId/project/$projectId/delete',
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


  void _handleError(DioException e) {
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
        Constants.errorSnackBar(
            title: 'Failed', message: '${e.response?.data['message']}');
        break;
      case DioExceptionType.cancel:
        Constants.errorSnackBar(title: 'Failed', message: 'Request cancelled');
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
