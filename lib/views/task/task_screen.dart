import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/dashboard/dashboard_screen.dart';
class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Constants.backgroundColor,
        child: Center(
          child: Text(
            'Welcome to the Task Screen',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontFamily: Constants.primaryFont,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    );
  }
}
