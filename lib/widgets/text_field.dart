import 'package:flutter/material.dart';
// generate text field widget
class MyTextField extends StatelessWidget {
  const MyTextField({super.key});
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter your email',
        hintText: 'Enter your email',
      ),
    );
  }
}

