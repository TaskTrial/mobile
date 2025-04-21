import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/cache_helper.dart';
import '../../utils/constants.dart';
import '../../views/main_view_screen.dart';
import '../main_view_controller.dart';

class CreateProjectController extends GetxController {
  final formKey = GlobalKey<FormState>();
  // Controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  // Observables
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().add(Duration(days: 1)).obs;
  final progress = 0.0.obs;
  final isSubmitting = false.obs;
  // Date formatter
  String formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  final selectedTeamId = ''.obs;


  // Date Pickers
  Future<void> pickStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      startDate.value = picked;
      if (picked.isAfter(endDate.value)) {
        endDate.value = picked.add(Duration(days: 1));
      }
    }
  }

  Future<void> pickEndDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: endDate.value,
      firstDate: startDate.value,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      endDate.value = picked;
    }
  }

  // Submit logic
  void submitProject() {
    if (!formKey.currentState!.validate()) return;
    isSubmitting.value = true;
     createProject();
     isSubmitting.value = false;
  }
  Future<void> createProject() async {
    Dio  dio = Dio();
    final projectData = {
      "name": nameController.text.trim(),
      "description": descriptionController.text.trim(),
      "startDate": formatDate(startDate.value),
      "endDate": formatDate(endDate.value),
      "progress": progress.value.round(),
    };
    String organizationId = CacheHelper().getData(key: 'orgId');
    String teamId =  selectedTeamId.value;
    print('http://192.168.1.5:3000/organization/$organizationId/team/$teamId/project');
    try {
      final response = await dio.post(
        'http://192.168.1.5:3000/api/organization/$organizationId/team/$teamId/project',
        data: projectData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${CacheHelper().getData(key: 'accessToken')}',
          },
        ),
      );
      Constants.successSnackBar(title: 'Success', message: 'Project created successfully');
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
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
