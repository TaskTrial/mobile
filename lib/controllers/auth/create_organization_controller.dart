import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/user_model.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/main_view_screen.dart';
import '../../utils/cache_helper.dart';
import '../../views/auth/login_screen.dart';

class CreateOrganizationController extends GetxController {
  var isLoading = false.obs;
  var getLoading = false.obs;
  final nameController = TextEditingController();
  final industryController = TextEditingController();
  final sizeRangeController = TextEditingController();
  final contactEmailController = TextEditingController();
 UserModel userModel = UserModel();
  final formKey = GlobalKey<FormState>();
  @override
  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  var initialize = false.obs;
  void _initialize() async {
    getLoading.value = true;
    bool ref = await _refreshToken();
    print(ref);
    await getUser();
    getLoading.value = false;
    if (userModel.user?.organization != null) {
      Get.offAll(() => MainViewScreen());
    } else {
      initialize.value = true;
    }
  }
  @override
  void onClose() {
    nameController.dispose();
    industryController.dispose();
    sizeRangeController.dispose();
    contactEmailController.dispose();
    super.onClose();
  }

  Future<void> createOrganization() async {
    isLoading.value = true;
    try {
      final dio = Dio();
      final token = CacheHelper().getData(key: 'accessToken');
      final response = await dio.post(
        'http://192.168.1.5:3000/api/organization',
        data: {
          'name': nameController.text,
          'industry': industryController.text,
          'sizeRange': sizeRangeController.text,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Constants.successSnackBar( title: "Success",message:  "Organization created successfully");
        Get.offAll(()=> MainViewScreen());
      } else {
       Constants.errorSnackBar(title: "Error",message: "Failed to create organization");
      }
    } catch (e) {
     Constants.errorSnackBar(title: "Error",message:  e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  getUser() async {
    print('On init');
    try {
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
    } on DioException catch (e) {
      // If token is expired
      if (e.response?.statusCode == 401) {
        print("Access token expired. Trying to refresh...");
        final refreshed = await _refreshToken();
        if (refreshed) {
          return await getUser();
        } else {
          // If refresh failed, logout
          _handleLogout();
          return;
        }
      }
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          Constants.errorSnackBar(title: 'Error', message: 'Connection timeout');
          break;
        case DioExceptionType.receiveTimeout:
          Get.snackbar('Error', 'Receive timeout');
          break;
        case DioExceptionType.sendTimeout:
          Get.snackbar('Error', 'Send timeout');
          break;
        case DioExceptionType.badResponse:
          {
            Get.snackbar('Error', 'Bad response: ${e.response?.data['message']}');
            _handleLogout();
          }
          break;
        case DioExceptionType.cancel:
          Get.snackbar('Error', 'Request cancelled');
          break;
        case DioExceptionType.unknown:
          Get.snackbar('Error', 'Unexpected error: ${e.message}');
          break;
        case DioExceptionType.badCertificate:
          Get.snackbar('Error', 'Bad certificate');
          break;
        case DioExceptionType.connectionError:
          Get.snackbar('Error', 'Connection error');
          break;
      }
    }
  }
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = CacheHelper().getData(key: 'refreshToken');
      final response = await Dio().post(
        'http://192.168.1.5:3000/api/auth/refreshAccessToken',
        data: {
          'refreshToken': refreshToken,
        },
      );
      CacheHelper().saveData(key: 'accessToken', value: response.data['accessToken']);
      print("Token refreshed successfully.");
      return true;
    } on DioException catch (e) {
      print("Token refresh failed: ${e.message}");
      return false;
    }
  }

  void _handleLogout() {
    CacheHelper().removeData(key: 'id');
    CacheHelper().removeData(key: 'accessToken');
    CacheHelper().removeData(key: 'refreshToken');
    Get.offAll(() => LoginScreen());
  }
}
