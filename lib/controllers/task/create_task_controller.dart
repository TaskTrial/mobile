import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_trial/models/project_model.dart';

import '../../../utils/cache_helper.dart';
import '../../../utils/constants.dart';
import '../../../views/main_view_screen.dart';
import '../main_view_controller.dart';


class CreateTaskController extends GetxController {
  final formKey = GlobalKey<FormState>();
  // Controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDate = DateTime.now().obs;
  final isSubmitting = false.obs;
  // Date formatter
  String formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  Rx<ProjectModel?> selectedProject = Rx<ProjectModel?>(null);
  RxString selectedProjectId = ''.obs;
  RxString selectedTeamId = ''.obs;
  RxString selectedPriority = ''.obs;


  // Date Pickers
  Future<void> pickDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dueDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dueDate.value = picked;
      if (picked.isAfter(dueDate.value)) {
        dueDate.value = picked.add(Duration(days: 1));
      }
    }
  }

  // Submit logic
  void submitTask() {
    if (!formKey.currentState!.validate()) return;
    isSubmitting.value = true;
    createTask();
    isSubmitting.value = false;
  }
  Future<void> createTask() async {
    Dio  dio = Dio();
    final taskData = {
      "title": titleController.text.trim(),
      "description": descriptionController.text.trim(),
      "dueDate": formatDate(dueDate.value),
      "priority":selectedPriority.value,
    };
    String organizationId = CacheHelper().getData(key: 'orgId');
    String teamId =  selectedTeamId.value;
    String projectId =  selectedProjectId.value;

    print('http://192.168.1.4:3000/api/organization/$organizationId/team/$teamId/project/$projectId/task/create');
    try {
      final response = await dio.post(
        'http://192.168.1.4:3000/api/organization/$organizationId/team/$teamId/project/$projectId/task/create',
        data: taskData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${CacheHelper().getData(key: 'accessToken')}',
          },
        ),
      );
      Constants.successSnackBar(title: 'Success', message: 'Task created successfully');
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
  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
