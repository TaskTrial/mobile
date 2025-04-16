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
    this.radius = 5,
    this.suffixIcon,
    this.readOnly=false
  });
  final String title;
  final String hintText;
  final bool obscureText;
  final bool isPassword;
  final VoidCallback? onPressed;
  final TextEditingController ? controller;
  final String? Function(String?)?  validator;
  final TextInputType? keyboardType ;

  final bool readOnly ;

  final Widget? suffixIcon ;

  final double radius ;
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
          readOnly: readOnly,
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
            fillColor: Colors.white,
            filled: true,
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
                    : suffixIcon,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
            errorStyle: TextStyle(
              fontSize: 12,
              fontFamily: Constants.primaryFont,
              fontWeight: FontWeight.w700,
              color: Constants.primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 5),
            ),
            enabledBorder: OutlineInputBorder(

              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                  color: Constants.pageNameColor.withValues(alpha: 0.2), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(color: Constants.primaryColor),
            ),
          ),
        )
      ],
    );
  }
}
