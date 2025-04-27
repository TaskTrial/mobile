
import 'package:get/get.dart';
import 'package:task_trial/services/department_services.dart';

import '../utils/cache_helper.dart';
import '../views/auth/login_screen.dart';
class CreateDepartmentController extends GetxController {
  final name = ''.obs;
  final description = ''.obs;
  final isLoading = false.obs;
  Future<void> createDepartment(String organizationId) async {
    DepartmentServices.createDepartment(organizationId: organizationId, name: name, description: description, isLoading: isLoading);
  }

}
