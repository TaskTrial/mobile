import 'package:flutter/material.dart';

import '../utils/constants.dart';
class GoogleSignInUI extends StatelessWidget {
  const GoogleSignInUI({super.key,required this.onPressed});

  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Constants.pageNameColor.withOpacity(0.2),width: 1.5),
      
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/google.png',height: 20,width: 20,),
            const SizedBox(width: 10,),
            Text(
              'Continue with Google',
              style: TextStyle(
                fontSize: 14,
                color: Constants.pageNameColor,
                fontFamily: Constants.primaryFont,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const Spacer(),
            // Icon(Icons.arrow_forward_ios,color: Constants.primaryColor,size: 20,)
          ],
        ),
      ),
    );
  }
}
