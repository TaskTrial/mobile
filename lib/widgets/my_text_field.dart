import 'package:flutter/material.dart';
import 'package:task_trial/utils/constants.dart';

// generate text field widget
class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.title = 'Title',
    this.hintText = 'hintText',
    this.obscureText = false,
    this.isPassword = false,
    this.onPressed,
    this.controller,
    this.validator,
    this.keyboardType,
  });
  final String title;
  final String hintText;
  final bool obscureText;
  final bool isPassword;
  final VoidCallback? onPressed;
  final TextEditingController ? controller;
  final String? Function(String?)?  validator;
  final TextInputType? keyboardType ;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 14,
              fontFamily: Constants.primaryFont,
              fontWeight: FontWeight.bold,
              color: Constants.pageNameColor),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          style: TextStyle(
            fontSize: 14,
            color: Constants.pageNameColor,
            fontFamily: Constants.primaryFont,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            suffixIcon: isPassword && obscureText
                ? IconButton(
                    icon: Icon(
                      Icons.visibility_off,
                      color: Constants.pageNameColor.withValues(alpha: 0.2),
                    ),
                    onPressed: onPressed,
                  )
                : isPassword && !obscureText
                    ? IconButton(
                        icon: Icon(
                          Icons.visibility,
                          color: Constants.primaryColor.withValues(alpha: 0.2),
                        ),
                        onPressed: onPressed,
                      )
                    : null,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: Constants.pageNameColor.withValues(alpha: 0.2), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Constants.primaryColor),
            ),
          ),
        )
      ],
    );
  }
}
