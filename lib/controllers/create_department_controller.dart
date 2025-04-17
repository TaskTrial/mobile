import 'package:dio/dio.dart';
import 'package:get/get.dart';
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
    if (name.value.isEmpty || description.value.isEmpty) {
     Constants.errorSnackBar(title: 'Error', message: 'Please fill in all fields');
      return;
    }
    isLoading.value = true;
    print('http://192.168.1.5:3000/organizations/$organizationId/departments/create');
    try {
      final response = await _dio.post(
        'http://192.168.1.5:3000/api/organizations/$organizationId/departments/create',
        data: {
          "name": name.value,
          "description": description.value,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer ${CacheHelper().getData(key: 'accessToken')}',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Constants.successSnackBar(title: 'Success', message: 'Department created successfully');
        Get.delete<MainViewController>();
        Get.offAll(
              () => MainViewScreen(),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 300),
        );
      } else {
        Constants.errorSnackBar(title: 'Error',message: 'Failed to create department');
      }
    } catch (e) {
      Constants.errorSnackBar(title: 'Error',message: 'Something went wrong: $e');
      print( 'Error: $e' );
    } finally {
      isLoading.value = false;
    }
  }
}
