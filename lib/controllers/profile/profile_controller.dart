import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_trial/models/organization_model.dart';
import 'package:task_trial/models/user_model.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/main_view_screen.dart';

import '../../services/user_services.dart';
import '../../views/auth/login_screen.dart';
import '../main_view_controller.dart';

class ProfileController extends GetxController {
  UserModel userModel = Get.arguments['user'];
  OrganizationModel organizationModel = Get.arguments['org'];

  final usernameController =
      TextEditingController(text: '${Get.arguments['user'].user!.username}');
  final firstNameController =
      TextEditingController(text: '${Get.arguments['user'].user!.firstName}');
  final lastNameController =
      TextEditingController(text: '${Get.arguments['user'].user!.lastName}');
  final jobTitleController = TextEditingController(
    text: '${(Get.arguments['user'].user!.jobTitle) ?? ''}',
  );
  final emailController = TextEditingController(
    text: '${Get.arguments['user'].user!.email}',
  );
  final phoneNumberController = TextEditingController(
    text: '${(Get.arguments['user'].user!.phoneNumber) ?? ''}',
  );
  final bioController = TextEditingController(
    text: '${(Get.arguments['user'].user!.bio) ?? ''}',
  );
  XFile? profileImage;
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

  updateProfileData() async {
    UserServices.updateProfileData(
        firstNameController: firstNameController,
        lastNameController: lastNameController,
        phoneNumberController: phoneNumberController,
        jobTitleController: jobTitleController,
        bioController: bioController,
        timeZone: getTimeZoneOffset());
  }

  String getTimeZoneOffset() {
    final now = DateTime.now();
    final offset = now.timeZoneOffset;
    final hours = offset.inHours;
    final minutes = offset.inMinutes.remainder(60);
    final sign = hours >= 0 ? '+' : '-';
    // Format as UTC+2 or UTC+02:30
    final formattedOffset = minutes == 0
        ? 'UTC$sign${hours.abs()}'
        : 'UTC$sign${hours.abs().toString().padLeft(2, '0')}:${minutes.abs().toString().padLeft(2, '0')}';

    return formattedOffset;
  }

  uploadProfileImage(XFile image) {
    profileImage = image;
    update();
  }

  deleteProfileImage(XFile image) {
    profileImage = null;
    update();
  }

  updateProfilePicture(File imageFile) async {
    UserServices.updateProfileImage(imageFile);
  }

  @override
  void onClose() {
    profileImage = null;
    super.onClose();
  }
}
