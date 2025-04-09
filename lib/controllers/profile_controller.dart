import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/login_model.dart';
import 'package:task_trial/models/user_model.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/views/main_view_screen.dart';

import '../views/auth/login_screen.dart';
import 'main_view_controller.dart';
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
   editProfile() async{
     print('on init');
     try {
       final response = await Dio().put(
         'http://192.168.1.5:3000/api/users/${CacheHelper().getData(key: 'id')}',
         options: Options(
           headers: {
             'authorization': 'Bearer ${CacheHelper().getData(key: 'accessToken')}',
           },
         ),
         data: {
             "firstName": firstNameController.text,
             "lastName": lastNameController.text,
             "phoneNumber": phoneNumberController.text,
             "jobTitle": jobTitleController.text,
             "timezone": getTimeZoneOffset(),
             "bio": bioController.text,
             "role": "MEMBER",
             "departmentId": "",
             "organizationId": ""

         }
       );
       Get.delete<MainViewController>();
       Get.offAll(
             () =>  MainViewScreen(),
         transition: Transition.fade,
         duration: const Duration(milliseconds: 300),

       );
     }
     on DioException catch (e) {
       switch (e.type) {
         case DioExceptionType.connectionTimeout:
           Get.snackbar('Error', 'Connection timeout');
           break;
         case DioExceptionType.receiveTimeout:
           Get.snackbar('Error', 'Receive timeout');
           break;
         case DioExceptionType.sendTimeout:
           Get.snackbar('Error', 'Send timeout');
           break;
         case DioExceptionType.badResponse:
           {
             Get.snackbar(
                 'Error', 'Bad response: ${e.response!.data['message']}');
           }
           break;
         case DioExceptionType.cancel:
           Get.snackbar('Error', 'Request cancelled');
           break;
         case DioExceptionType.unknown:
           Get.snackbar('Error', 'Unexpected error: ${e.message}');
           break;
         case DioExceptionType.badCertificate:
           Get.snackbar('Error', 'Bad certificate');
           break;
         case DioExceptionType.connectionError:
           Get.snackbar('Error', 'Connection error');
           break;
       }
     }
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


}