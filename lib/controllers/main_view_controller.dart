import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/departments_model.dart';
import 'package:task_trial/models/organization_model.dart';
import 'package:task_trial/models/user_model.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/auth/login_screen.dart';
import 'package:task_trial/views/chat/chat_screen.dart';
import 'package:task_trial/views/dashboard/dashboard_screen.dart';
import 'package:task_trial/views/more/more_screen.dart';
import 'package:task_trial/views/project/project_screen.dart';
import 'package:task_trial/views/task/task_screen.dart';

class MainViewController extends GetxController {
  final currentPageIndex = 0.obs;
  final isLoading = false.obs;
  final PageController pageController = PageController(initialPage: 0);
  late List<Widget> pages;
  final List<String> pageNames = ['Dashboard', 'Projects', 'Chat', 'Tasks', 'More'];
  UserModel userModel = UserModel();
  OrganizationModel organizationModel = OrganizationModel();
  DepartmentsModel departmentsModel = DepartmentsModel();
  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await getUser();
    await getOrganization();
    await getDepartments();
    pages = [
      DashboardScreen(),
      ProjectScreen(),
      ChatScreen(),
      TaskScreen(),
      MoreScreen(organization: organizationModel , departments: departmentsModel,),
    ];
    pageController.addListener(() {
      currentPageIndex.value = pageController.page?.round() ?? 0;
    });

    isLoading.value = false;
  }

  @override
  void dispose() {
    pageController.dispose();
    Get.delete<MainViewController>();
    super.dispose();
  }

  void onPageSelected(int index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }
  Future<void> getUser() async {
    print('Get User Method');
    final refreshToken = CacheHelper().getData(key: 'refreshToken');
    final accessToken = CacheHelper().getData(key: 'accessToken');
    print(accessToken);
    final userId = CacheHelper().getData(key: 'id');
    try {
      final response = await Dio().get(
        'http://192.168.1.5:3000/api/users/$userId',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );

      userModel = UserModel.fromJson(response.data);
      print(userModel.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 && await _refreshToken()) {
        return await getUser(); // Retry after refresh
      } else {
        _handleDioError(e);
      }
    }
  }
  Future<void> getOrganization() async {
    print('Get Organization Method');
    final accessToken = CacheHelper().getData(key: 'accessToken');
    final orgId = userModel.user?.organization['id'];
    try {
      final response = await Dio().get(
        'http://192.168.1.5:3000/api/organization/$orgId',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );

      organizationModel = OrganizationModel.fromJson(response.data);
      print(organizationModel.toJson());
      CacheHelper().saveData(key: 'orgId', value: organizationModel.id);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 && await _refreshToken()) {
        return await getOrganization(); // Retry after refresh
      } else {
        _handleDioError(e);
      }
    }
  }
  Future<void> getDepartments() async {
    print('Get Departments Method');
    final accessToken = CacheHelper().getData(key: 'accessToken');
    final orgId = userModel.user?.organization['id'];
    try {
      final response = await Dio().get(
        'http://192.168.1.5:3000/api/organizations/$orgId/departments/all',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      departmentsModel = DepartmentsModel.fromJson(response.data);
      print(departmentsModel.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 && await _refreshToken()) {
        return await getDepartments(); // Retry after refresh
      } else {
       Constants.errorSnackBar(title: 'Error', message: e.toString());
       print(e.toString());
      }
    }
  }
  Future<bool> _refreshToken() async {
    final refreshToken = CacheHelper().getData(key: 'refreshToken');
    if (refreshToken == null) return false;
    try {
      final response = await Dio().post(
        'http://192.168.1.5:3000/api/auth/refreshAccessToken',
        data: {'refreshToken': refreshToken},
      );
      CacheHelper().saveData(key: 'accessToken', value: response.data['accessToken']);
      if (response.data['refreshToken'] != null) {
        CacheHelper().saveData(key: 'refreshToken', value: response.data['refreshToken']);
      }
      return true;
    } catch (e) {
      print("Token refresh failed.");
      return false;
    }
  }
  void _handleLogout() {
    CacheHelper().removeData(key: 'id');
    CacheHelper().removeData(key: 'accessToken');
    CacheHelper().removeData(key: 'refreshToken');
    Get.offAll(() => LoginScreen());
  }
  void _handleDioError(DioException e) {
    isLoading.value = false;

    final message = e.response?.data['message'] ?? e.message;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        Constants.errorSnackBar(title: 'Timeout', message: 'Please try again later.');
        break;
      case DioExceptionType.badResponse:
        Constants.errorSnackBar(title: 'Error', message: message);
        _handleLogout();
        break;
      case DioExceptionType.unknown:
      case DioExceptionType.connectionError:
        Constants.errorSnackBar(title: 'Error', message: 'Network error: $message');
        break;
      case DioExceptionType.cancel:
        Constants.errorSnackBar(title: 'Cancelled', message: 'Request was cancelled.');
        break;
      case DioExceptionType.badCertificate:
        Constants.errorSnackBar(title: 'Security', message: 'Bad SSL certificate.');
        break;
    }
  }
}
