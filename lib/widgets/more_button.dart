import 'package:flutter/material.dart';
import 'package:task_trial/utils/constants.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({super.key, this.onTap,  required this.icon, required this.label});
  final  void Function()? onTap ;
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Icon(
             icon,color: Constants.primaryColor,
             size: 30,
           ),
            SizedBox(width: 15,),
            Text(label,
                style: TextStyle(
                  fontFamily: Constants.primaryFont,
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
            ),
            Spacer(),
            Icon( Icons.arrow_forward_ios,color: Colors.white,size: 20,)
          ]
        ),
      ),
    );
  }
}
