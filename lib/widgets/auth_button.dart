import 'package:flutter/material.dart';
import 'package:task_trial/utils/constants.dart';
class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.isLoading,
  });
  final VoidCallback onPressed;
  final String title;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Constants.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child:!isLoading? Text(
          title,
          style:  TextStyle(
            fontSize: 18,
            fontFamily: Constants.primaryFont,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ):CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}