import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/organization_model.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/chat/chat_screen.dart';
import 'package:task_trial/views/dashboard/dashboard_screen.dart';
import 'package:task_trial/views/more/more_screen.dart';
import 'package:task_trial/views/profile/profile_screen.dart';
import 'package:task_trial/views/project/project_screen.dart';
import 'package:task_trial/views/task/task_screen.dart';
import '../models/user_model.dart';
import '../views/auth/login_screen.dart';
class MainViewController extends GetxController {
  var currentPageIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);
  List<Widget> pages = [
    DashboardScreen(),
    ProjectScreen(),
    ChatScreen(),
    TaskScreen(),
    MoreScreen()
  ];
  List<String> pageNames = [
    'Dashboard',
    'Projects',
    'Chat',
    'Tasks',
    'More'
  ];
  final isLoading = false.obs;
   UserModel userModel = UserModel();
    OrganizationModel organizationModel = OrganizationModel() ;
  @override
  void onInit() async{
    await getUser();
    await getOrganization();
    super.onInit();
    pageController.addListener(() {
      currentPageIndex.value = pageController.page!.round();
    });

  }

  @override
  @override
  void dispose() {
    Get.delete<MainViewController>(); // This will trigger `onClose()`
    super.dispose();
  }
  void onTapped(int index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onPageTapped(int index) {
    pageController.jumpToPage(index);
  }
  void onPageSwiped(int index) {
    currentPageIndex.value = index;
  }
  void onPageChanged(int index) {
    currentPageIndex.value = index;
  }
  void onPageScroll(int index) {
    currentPageIndex.value = index;
  }
  void onPageScrollEnd(int index) {
    currentPageIndex.value = index;
  }

  Future<void> getUser() async {
    print('on init');
    print('------------------------Refresh Token------------------------');
    print(CacheHelper().getData(key: 'refreshToken'));
    print('------------------------Refresh Token------------------------');
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
          return await getUser();
        } else {
          // If refresh failed, logout
          _handleLogout();
          return;
        }
      }
      isLoading.value = false;
      print(isLoading.value);

      // Other Dio exceptions
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
  Future<void> getOrganization() async {
    print('get Organization');
    try {
      isLoading.value = true;
      print(isLoading.value);
      print(userModel.user!.organization['id']);
      final response = await Dio().get(
        'http://192.168.1.5:3000/api/organization/${userModel.user!.organization['id']}',
        options: Options(
          headers: {
            'authorization': 'Bearer ${CacheHelper().getData(key: 'accessToken')}',
          },
        ),
      );
      organizationModel = OrganizationModel.fromJson(response.data);
      print(organizationModel.toJson());
      isLoading.value = false;
      print(isLoading.value);
    } on DioException catch (e) {
      // If token is expired
      if (e.response?.statusCode == 401) {
        print("Access token expired. Trying to refresh...");
        final refreshed = await _refreshToken();

        if (refreshed) {
          // Retry original request
          return await getUser();
        } else {
          // If refresh failed, logout
          _handleLogout();
          return;
        }
      }
      isLoading.value = false;
      print(isLoading.value);
      // Other Dio exceptions
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
      if (refreshToken == null) {
        print("No refresh token found.");
        return false;
      }

      print("Sending refresh token: $refreshToken");

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
      print("Token refresh failed: ${e.response?.statusCode} - ${e.response?.data}");
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