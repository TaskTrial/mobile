import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/utils/cache_helper.dart';
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

  @override
  // void onInit() async{
  //   getUser();
  //   super.onInit();
  //   pageController.addListener(() {
  //     currentPageIndex.value = pageController.page!.round();
  //   });
  //
  //
  // }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
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

  getUser() async{
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

    }
    on DioException catch (e) {
      isLoading.value = false;
      print(isLoading.value);
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          Get.snackbar('Error', 'Connection timeout');
          break;
        case DioExceptionType.receiveTimeout:
          Get.snackbar('Error', 'Receive timeout');
          break;
        case DioExceptionType.sendTimeout:
          Get.snackbar('Error', 'Send timeout');
          break;
        case DioExceptionType.badResponse:
          {
            Get.snackbar(
                'Error', 'Bad response: ${e.response!.data['message']}');
                 CacheHelper().removeData(key: 'id');
                 CacheHelper().removeData(key: 'accessToken');
                 CacheHelper().removeData(key: 'refreshToken');
                 Get.offAll(() => LoginScreen());
                 isLoading.value = false;
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

}