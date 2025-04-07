import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/login_model.dart';
import 'package:task_trial/models/user_model.dart';
import 'package:task_trial/utils/cache_helper.dart';

import '../views/auth/login_screen.dart';
class ProfileController extends GetxController{
   UserModel userModel = Get.arguments;
  final usernameController = TextEditingController(text:'${Get.arguments.user!.username}');
  final firstNameController = TextEditingController(text: '${Get.arguments.user!.firstName}');
  final lastNameController = TextEditingController(text: '${Get.arguments.user!.lastName}');

  final jobTitleController = TextEditingController(
    text: '${(Get.arguments.user!.jobTitle)??''}',
  );
  final emailController = TextEditingController(
    text: '${Get.arguments.user!.email}',
  );
  final phoneNumberController = TextEditingController(
    text: '${(Get.arguments.user!.phoneNumber)??''}',
  );

  final bioController = TextEditingController(
    text: '${(Get.arguments.user!.bio)??''}',
  );
  final formKey = GlobalKey<FormState>();

  logout() {
   CacheHelper().removeData(key: 'id');
    CacheHelper().removeData(key: 'refreshToken');
   CacheHelper().removeData(key: 'accessToken').then(
      (value) {
        if (value) {
          Get.offAll(
            () => LoginScreen(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500),
          );
        }
      },
   );

  }


}