import 'package:flutter/material.dart';

import '../utils/constants.dart';

class EditPhotoButton extends StatelessWidget {
  const EditPhotoButton({super.key,required this.icon ,this.color, this.onPressed});

  final IconData? icon ;
  final Color? color;

  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: CircleBorder(
        ),

      ),
      child:  Icon(
        icon,
        color: Colors.white,
        size: 30,),
    );
  }
}
