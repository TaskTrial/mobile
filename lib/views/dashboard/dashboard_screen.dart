import 'package:flutter/material.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/widgets/custom_drop_down_menu.dart';
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(left: 16.0,right: 16,top: 40,bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Overall',style: TextStyle(
                    fontFamily: Constants.primaryFont,
                    fontSize: 16,fontWeight: FontWeight.bold),),
                CustomDropDownMenu()
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                 _overallCard(),
                  SizedBox(width: 10,),
                  _overallCard(),
                  SizedBox(width: 10,),
                  _overallCard(),
                ],
              ),
            )
          ],
          )
          ],
        )
      )
    );
  }
  _overallCard() {
    return Container(
      width: 200,
      height: 100,
      color: Constants.transparentWhite,
    );
  }
}
