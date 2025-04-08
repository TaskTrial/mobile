import 'dart:math';

import 'package:flutter/material.dart';
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


 }