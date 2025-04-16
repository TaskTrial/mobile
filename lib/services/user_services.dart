import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:task_trial/models/user_model.dart';

import '../utils/cache_helper.dart';
import '../utils/constants.dart';
import '../views/auth/login_screen.dart';

class UserServices {
  static Future<void> getUser({required UserModel userModel, required RxBool isLoading}) async {
    print('on init');
    try {
      isLoading.value = true;
      print(isLoading.value);
      final response = await Dio().get(
        'http://192.168.1.5:3000/api/users/${CacheHelper().getData(key: 'id')}',
        options: Options(
          headers: {
            'authorization': 'Bearer ${CacheHelper().getData(key: 'accessToken')}',
          },
        ),
      );
      userModel = UserModel.fromJson(response.data);
      print(userModel.user!.toJson());
      isLoading.value = false;
      print(isLoading.value);

    } on DioException catch (e) {
      // If token is expired
      if (e.response?.statusCode == 401) {
        print("Access token expired. Trying to refresh...");
        final refreshed = await _refreshToken();

        if (refreshed) {
          // Retry original request
          return await getUser(isLoading: isLoading, userModel: userModel);
        } else {
          // If refresh failed, logout
          _handleLogout();
          return;
        }
      }
      isLoading.value = false;
      print(isLoading.value);
      // Other Dio exceptions
      _handleError(e);
    }
  }
 static Future<bool> _refreshToken() async {
    try {
      final refreshToken = CacheHelper().getData(key: 'refreshToken');
      final response = await Dio().post(
        'http://192.168.1.5:3000/api/auth/refreshAccessToken',
        data: {
          'refreshToken': refreshToken,
        },
      );
      CacheHelper().saveData(key: 'accessToken', value: response.data['accessToken']);
      if (response.data['refreshToken'] != null) {
        CacheHelper().saveData(key: 'refreshToken', value: response.data['refreshToken']);
      }
      print("Token refreshed successfully.");
      return true;
    } on DioException catch (e) {
      print("Token refresh failed: ${e.message}");
      return false;
    }
  }

 static void _handleLogout() {
    CacheHelper().removeData(key: 'id');
    CacheHelper().removeData(key: 'accessToken');
    CacheHelper().removeData(key: 'refreshToken');
    Get.offAll(() => LoginScreen());
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
          _handleLogout();
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

