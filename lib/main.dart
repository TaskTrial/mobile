import 'package:flutter/material.dart';
import 'package:task_trial/app.dart';
import 'package:task_trial/utils/cache_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  runApp(const MyApp());
}




