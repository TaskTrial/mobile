import 'package:flutter/material.dart';
import 'package:task_trial/utils/constants.dart';
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Constants.backgroundColor,
        child: Center(
          child: Text(
            'Welcome to the Dashboard Screen',
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
