import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/main_view_controller.dart';
import 'package:task_trial/utils/constants.dart';
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Constants.backgroundColor,
        child: Center(
          child: Text(
            'Welcome to the More Screen',
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
