import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/main_view_controller.dart';
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text(
          'Welcome to the Menu Screen',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
