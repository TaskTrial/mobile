import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/user_model.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/main_view_screen.dart';
import '../../utils/cache_helper.dart';
import '../../views/auth/login_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class CreateOrganizationController extends GetxController {
  var isLoading = false.obs;
  var getLoading = false.obs;
  var joinLoading = false.obs;
  final nameController = TextEditingController();
  final industryController = TextEditingController();
  final sizeRangeController = TextEditingController();
  final contactEmailController = TextEditingController();
  final joinCodeController = TextEditingController();

   var hasOrganization =true.obs;
 UserModel userModel = UserModel();
  final formKey = GlobalKey<FormState>();
  @override
  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  Future<bool> hasInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  var initialize = false.obs;
  void _initialize() async {
    getLoading.value = true;
    bool isOnline = await hasInternetConnection();
    if (!isOnline) {
      getLoading.value = false;
      Get.snackbar(
        'No Internet Connection',
        'Please check your network and try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,

      );
      return;
    }
    bool ref = await _refreshToken();
    print(ref);
    await orgStatus();
    getLoading.value = false;
    if (hasOrganization.value == true) {
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
        'https://tasktrial-prod.vercel.app/api/organization',
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
  logout() {
    CacheHelper().removeData(key: 'id');
    CacheHelper().removeData(key: 'refreshToken');
    CacheHelper().removeData(key: 'accessToken').then(
          (value) {
        if (value) {
          Get.offAll(
                () => LoginScreen(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500),
          );
        }
      },
    );
  }
  Future<void> orgStatus()async{
    print('check org status');
    try {
      final response = await Dio().get(
        'https://tasktrial-prod.vercel.app/api/organization/status',
        options: Options(
          headers: {
            'authorization': 'Bearer ${CacheHelper().getData(key: 'accessToken')}',
          },
        ),
      );
      hasOrganization.value=response.data['hasOrganization'];
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        print("Access token expired. Trying to refresh...");
        final refreshed = await _refreshToken();
        if (refreshed) {
          return await orgStatus();
        } else {
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
  Future<void> joinOrganization() async {
    joinLoading.value = true;
    try {
      final dio = Dio();
      final token = CacheHelper().getData(key: 'accessToken');
      final response = await dio.post(
        'https://tasktrial-prod.vercel.app/api/organization/join',
        data: {
          "joinCode": joinCodeController.text
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Constants.successSnackBar( title: "Success",message:  "Organization joined successfully");
        Get.offAll(()=> MainViewScreen());
      } else {
        Constants.errorSnackBar(title: "Error",message: "Failed to join organization");
      }
    } catch (e) {
      Constants.errorSnackBar(title: "Error",message:  e.toString());
    } finally {
      joinLoading.value = false;
    }

  }
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = CacheHelper().getData(key: 'refreshToken');
      final response = await Dio().post(
        'https://tasktrial-prod.vercel.app/api/auth/refreshAccessToken',
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
