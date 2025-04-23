import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:task_trial/services/department_services.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';

import '../views/main_view_screen.dart';
import 'main_view_controller.dart';

class CreateDepartmentController extends GetxController {
  final name = ''.obs;
  final description = ''.obs;
  final isLoading = false.obs;
  final Dio _dio = Dio();
  Future<void> createDepartment(String organizationId) async {
    DepartmentServices.createDepartment(organizationId: organizationId, name: name, description: description, isLoading: isLoading);
  }
}
