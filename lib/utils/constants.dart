import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class Constants {
  static const Color primaryColor = Color(0xFFE65F2B);
  static const Color backgroundColor = Color(0xFFEBDFD7);
  static const Color pageNameColor = Color(0xFF525252);
  static const Color projectCardColor1 = Color(0xFFF8E9C8);
  static const Color projectCardColor2 = Color(0xFFDEECEC);
  static const Color projectCardColor3 = Color(0xFFecdede);
  static const Color projectCardColor4 = Color(0xFFdedeec);



  static  Color transparentWhite = Color(0xFFFFFFFF).withOpacity(0.34);
  static const String appName = 'TaskTrial';
  static const String primaryFont = 'NunitoSans';
  static const String imagesPath = 'assets/images/';
  static const String tabsPath = 'assets/images/tabs/';
  static const String baseUrl =  'https://192.168.1.5:3000/api/';
  static const String signUpUrl = 'auth/signup';
  static const String loginUrl = 'auth/signin';

  static Color getRandomProjectCardColor() {
    final colors = [projectCardColor1, projectCardColor2];
    return colors[Random().nextInt(colors.length)];
  }

  static errorSnackBar({required String title, required String message,SnackPosition snackPosition = SnackPosition.TOP}) {
    return Get.snackbar(title, message,
      colorText: Colors.white,
      backgroundColor: Colors.white,
      icon: const Icon(Icons.error, color: Colors.white),
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: Constants.primaryFont,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: Constants.primaryFont,
        ),
      ),
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      backgroundGradient:  LinearGradient(
        colors: [ Colors.redAccent.shade700,Colors.red ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      duration: const Duration(seconds: 2),
      snackPosition: snackPosition,
      reverseAnimationCurve:  Curves.easeInOut,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
  static completeSnackBar({required String title, required String message,SnackPosition snackPosition = SnackPosition.TOP }) {
    return Get.snackbar(title, message,
      colorText: Colors.white,
      backgroundColor: Colors.white,
      icon: const Icon( Icons.check , color: Colors.white),
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: Constants.primaryFont,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: Constants.primaryFont,
        ),
      ),
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      backgroundGradient:  LinearGradient(
        colors: [ Colors.greenAccent.shade700,Colors.green ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      duration: const Duration(seconds: 2),
      snackPosition: snackPosition,
      reverseAnimationCurve:  Curves.easeInOut,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }




 }