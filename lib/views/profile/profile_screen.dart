import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/user_model.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/views/auth/login_screen.dart';
class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});
  UserModel args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
            ),
            SizedBox(height: 20),
            Text(
              args.user!.username!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'johndoe@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            ElevatedButton(onPressed:(){
              CacheHelper().removeData(key: 'id');
              CacheHelper().removeData(key: 'accessToken');
              CacheHelper().removeData(key: 'refreshToken');
              Get.offAll(() => LoginScreen(),
                transition: Transition.fadeIn,
                duration: Duration(milliseconds: 500),
              );
            } , child: Text('logout')),
          ]
        ),
      )
    );
  }
}
