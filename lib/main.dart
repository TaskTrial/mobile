import 'package:flutter/material.dart';
import 'package:task_trial/app.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(); // ✅ Load .env
  await CacheHelper().init(); // ✅ Ensure your cache helper is also initialized
  runApp(const MyApp());
}





