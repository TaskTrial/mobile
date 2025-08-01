import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../controllers/main_view_controller.dart';
import '../utils/cache_helper.dart';
import '../utils/constants.dart';
import '../views/main_view_screen.dart';

class TeamServices {


  static Future<void> removeMember({required String userId ,required String teamId
  })async{
    String orgId = CacheHelper().getData(key: 'orgId');
    print('https://tasktrial-prod.vercel.app/api/organization/$orgId/team/$teamId/members/$userId');
    try {
      final response = await Dio().delete(
          'https://tasktrial-prod.vercel.app/api/organization/$orgId/team/$teamId/members/$userId',
          options: Options(
            headers: {
              'authorization':
              'Bearer ${CacheHelper().getData(key: 'accessToken')}',
            },
          ),
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
    required List<Map<String, String>> users,
  }) async {
    String orgId = CacheHelper().getData(key: 'orgId');
    try {
      final response = await Dio().post(
        'https://tasktrial-prod.vercel.app/api/organization/$orgId/team/$teamId/addMember',
        options: Options(
          headers: {
            'authorization': 'Bearer ${CacheHelper().getData(key: 'accessToken')}',
          },
        ),
        data: {
          "members": users,
        },
      );

      Constants.successSnackBar(
          title: 'Success', message: 'Users Added Successfully!');
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




  static  void _handleError(DioException e){
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