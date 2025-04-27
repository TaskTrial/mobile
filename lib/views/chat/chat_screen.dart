import 'package:flutter/material.dart';

import 'package:task_trial/utils/constants.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Constants.backgroundColor,
        child: Center(
          child: Text(
            'Welcome to the Chat Screen',
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
