import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/departments_model.dart';
import 'package:task_trial/models/organization_model.dart';
import 'package:task_trial/models/project_model.dart';
import 'package:task_trial/models/teams_model.dart';
import 'package:task_trial/models/user_model.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/auth/login_screen.dart';
import 'package:task_trial/views/chat/chat_screen.dart';
import 'package:task_trial/views/dashboard/dashboard_screen.dart';
import 'package:task_trial/views/more/more_screen.dart';
import 'package:task_trial/views/project/project_screen.dart';
import 'package:task_trial/views/task/task_screen.dart';

import '../models/task_model.dart';

class MainViewController extends GetxController {
  final currentPageIndex = 0.obs;
  final isLoading = false.obs;
  final PageController pageController = PageController(initialPage: 0);
  late List<Widget> pages;
  final List<String> pageNames = ['Dashboard', 'Projects',  'Tasks', 'More'];
  UserModel userModel = UserModel();
  OrganizationModel organizationModel = OrganizationModel();
  DepartmentsModel departmentsModel = DepartmentsModel();
  TeamsModel teamsModel = TeamsModel();
  List<ProjectModel> projectModel = [];
  List<TaskModel> tasks = [];
  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await getUser();
    await getOrganization();
    await getDepartments();
    await getTeams();
     await getAllProjects();
     await getAllTasks();
    pages = [
      DashboardScreen(
        projects: projectModel,
        tasks: tasks,
      ),
      ProjectScreen(projects: projectModel,teams: teamsModel.data!.teams!,),

      TaskScreen(tasks: tasks,projects: projectModel,),
      MoreScreen(organization: organizationModel , departments: departmentsModel,teams: teamsModel,),
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
    final accessToken = CacheHelper().getData(key: 'accessToken');
    print(accessToken);
    final userId = CacheHelper().getData(key: 'id');
    try {
      final response = await Dio().get(
        'http://192.168.1.4:3000/api/users/$userId',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      userModel = UserModel.fromJson(response.data);
      print(userModel.toJson());
    } on DioException catch (e) {
      isLoading.value = false;
      if (e.response?.statusCode == 401 && await _refreshToken()) {
        return await getUser(); // Retry after refresh
      } else {
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
  }
  Future<void> getOrganization() async {
    print('Get Organization Method');
    final accessToken = CacheHelper().getData(key: 'accessToken');
    final orgId = userModel.user?.organization['id'];
    print(orgId);
    try {
      final response = await Dio().get(
        'http://192.168.1.4:3000/api/organization/$orgId',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      print(response);
      organizationModel = OrganizationModel.fromJson(response.data['data']);
      for(var i = 0; i < organizationModel.users!.length; i++){
        print(organizationModel.users![i].toJson());
      }
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
        'http://192.168.1.4:3000/api/organizations/$orgId/departments/all',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      departmentsModel = DepartmentsModel.fromJson(response.data);
      print(departmentsModel.toJson());
    } on DioException catch (e) {
     _handleDioError(e);
    }
  }
  Future<void> getTeams() async {
    print('Get Teams Method');
    final accessToken = CacheHelper().getData(key: 'accessToken');
    final orgId = CacheHelper().getData(key: 'orgId');
    try {
      final response = await Dio().get(
        'http://192.168.1.4:3000/api/organization/$orgId/teams/all',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      teamsModel = TeamsModel.fromJson(response.data);
      print(teamsModel.toJson());
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }
  Future<void> getAllProjects() async {
    print('Get All Projects Method');
    final accessToken = CacheHelper().getData(key: 'accessToken');
    final orgId = CacheHelper().getData(key: 'orgId');
    try {
      final response = await Dio().get(
        'http://192.168.1.4:3000/api/organization/$orgId/projects',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      List data=response.data['data']['activeProjects'];
      for (var project in data) {
        ProjectModel p = ProjectModel.fromJson(project);
        projectModel.add(p);
      }
      for(ProjectModel proj in projectModel){
        print(proj.toJson());
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }
  Future<void> getAllTasks() async {
    print('Get All Tasks Method');
    final accessToken = CacheHelper().getData(key: 'accessToken');
    final orgId = CacheHelper().getData(key: 'orgId');
    try {
      final response = await Dio().get(
        'http://192.168.1.4:3000/api/organization/$orgId/tasks',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}),
      );
      List data=response.data['data']['tasks'];
      for (var task in data) {
        tasks.add(TaskModel.fromJson(task));
      }
      for(TaskModel task in tasks){
        print(task.toJson());
      }
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }
  Future<bool> _refreshToken() async {
    final refreshToken = CacheHelper().getData(key: 'refreshToken');
    print('ref $refreshToken');
    if (refreshToken == null) return false;
    try {
      final response = await Dio().post(
        'http://192.168.1.4:3000/api/auth/refreshAccessToken',
        data: {
          'refreshToken': refreshToken,
        }
      );
      CacheHelper().saveData(key: 'accessToken', value: response.data['accessToken']);
      print(response.data);
      return true;
    } catch (e) {
      print("Token refresh failed.");
      print( e.toString());
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
    final message = e.response?.data['message'] ?? e.message;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        Constants.errorSnackBar(title: 'Timeout', message: 'Please try again later.');
        break;
      case DioExceptionType.receiveTimeout:
        Constants.errorSnackBar(title: 'Timeout', message: 'Please try again later.');
        break;
      case DioExceptionType.sendTimeout:
        Constants.errorSnackBar(title: 'Timeout', message: 'Please try again later.');
        break;
      case DioExceptionType.badResponse:
        print(message);
        Constants.errorSnackBar(title: 'Error', message: e.response!.data['message']);
        break;
      case DioExceptionType.unknown:
         Constants.errorSnackBar(title: 'Error', message: 'Unknown error: $message');
        break;
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
