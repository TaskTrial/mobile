import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/project_model.dart';

import '../../models/task_model.dart';
import '../../utils/cache_helper.dart';
import '../../utils/constants.dart';
import '../../views/main_view_screen.dart';
import '../main_view_controller.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;
  var projects = <ProjectModel>[].obs;
  var filteredTasks = <TaskModel>[].obs;
  var selectedFilterIndex = 0.obs;
  int get allCount => tasks.length;
  int get todoCount => tasks.where((t) => t.status == 'TODO').length;
  int get inProgressCount => tasks.where((t) => t.status == 'IN_PROGRESS').length;
  int get completedCount => tasks.where((t) => t.status == 'DONE').length;
  int get inReviewCount => tasks.where((t) => t.status == 'REVIEW').length;
 String getTeamId(String projectId){
   for(var project in projects){
     if(project.id == projectId){
       return project.team!.id!;
     }
   }
   return '';
 }

  void setTasks(List<TaskModel> newTasks) {
    tasks.value = newTasks;
    filterTasks();
  }
  void setProjects(List<ProjectModel> newProjects) {
    projects.value = newProjects;
  }

  void changeFilter(int index) {
    selectedFilterIndex.value = index;
    filterTasks();
  }

  void filterTasks() {
    switch (selectedFilterIndex.value) {
      case 1:
        filteredTasks.value = tasks.where((t) => t.status == 'TODO').toList();
        break;
      case 2:
        filteredTasks.value = tasks.where((t) => t.status == 'IN_PROGRESS').toList();
        break;
      case 3:
        filteredTasks.value = tasks.where((t) => t.status == 'DONE').toList();
        break;
      case 4:
        filteredTasks.value = tasks.where((t) => t.status == 'REVIEW').toList();
        break;
      default:
        filteredTasks.value = tasks;
    }
  }
  Future<void> deleteTaskData({required String teamId,
    required String projectId,required String taskId,})async{
    String orgId = CacheHelper().getData(key: 'orgId');
    try {
      final response = await Dio().delete(
        'http://192.168.1.5:3000/api/organization/$orgId/team/$teamId/project/$projectId/task/$taskId/delete',
        options: Options(
          headers: {
            'authorization':
            'Bearer ${CacheHelper().getData(key: 'accessToken')}',
          },
        ),
      );
      Constants.successSnackBar(
          title: 'Success', message: 'Task Deleted Successfully !');
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
