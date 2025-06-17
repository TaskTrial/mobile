import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../utils/cache_helper.dart';
import '../../utils/constants.dart';
import '../../views/main_view_screen.dart';
import '../main_view_controller.dart';

class EditTaskController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateTaskData({
    required String teamId,
    required String projectId,
    required String taskId,
    required Map<String, dynamic> data,
  }) async {
    isLoading.value = true;
    final orgId = CacheHelper().getData(key: 'orgId');
    try {
      print('http://192.168.1.8:3000/api/organization/$orgId/team/$teamId/project/$projectId/task/$taskId');
      final response = await Dio().put(
        'http://192.168.1.8:3000/api/organization/$orgId/team/$teamId/project/$projectId/task/$taskId',
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
        message: 'Task Updated Successfully!',
      );
      Get.delete<MainViewController>();
      Get.offAll(() => MainViewScreen());
    } on DioException catch (e) {
      _handleError(e);
    } finally {
      isLoading.value = false;
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
