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
          _overallPart(),
          SizedBox(height: 20,),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Constants.transparentWhite,
                borderRadius: BorderRadius.circular(20),
              ),
            )
          ],
        )
      )
    );
  }
  _overallPart(){
    return Column(
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
              _overallCard(
                imageName: "revenue.png",
                percentage: '12%',
                title: 'Total revenue',
                amount: Text('\$53,009899',style: TextStyle(
                  color: Constants.pageNameColor,
                  fontFamily: Constants.primaryFont,
                  fontSize: 20,fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,

                ),),
              ),
              SizedBox(width: 10,),
              _overallCard(
                  imageName: "projects.png",
                  percentage: '20%',
                  title: 'Projects',
                  amount: _amount(amount: '95', total: '100')
              ),
              SizedBox(width: 10,),
              _overallCard(
                  imageName: "timeSpent.png",
                  percentage: '15%',
                  title: 'Time spent',
                  amount: _amount(amount: '1022', total: '1300 Hrs')
              ),
              SizedBox(width: 10,),
              _overallCard(
                  imageName: "resources.png",
                  percentage: '02%',
                  title: 'Resources',
                  amount: _amount(amount: '101', total: '120')
              ),
            ],
          ),
        )
      ],
    );
  }
  _overallCard(
      {required String imageName,required String title,required String percentage,required Widget amount}) {
    return Container(
      width: 150,
      height: 110,
      decoration: BoxDecoration(
        color: Constants.transparentWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("${Constants.imagesPath}$imageName",width: 45,height: 45,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,style: TextStyle(
                    color: Constants.pageNameColor,
                      fontFamily: Constants.primaryFont,
                      fontSize: 14,fontWeight: FontWeight.bold
                  ),),
                  Row(
                    children: [
                      Icon(Icons.keyboard_arrow_up_outlined,color: Colors.green,),
                      Text(percentage,style: TextStyle(
                        color: Constants.pageNameColor,
                          fontFamily: Constants.primaryFont,
                          fontSize: 12,fontWeight: FontWeight.bold
                      ),),
                    ],
                  )
                ],
              )
            ]
          ),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: double.infinity,
            child: amount,
            // child: Text('\$53,009899',style: TextStyle(
            //   color: Constants.pageNameColor,
            //     fontFamily: Constants.primaryFont,
            //     fontSize: 20,fontWeight: FontWeight.bold,
            //   overflow: TextOverflow.ellipsis,
            //
            // ),),
          )
        ],
      ),
    );
  }
  _amount( {required String amount,required String total}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(amount,style: TextStyle(
          color: Constants.pageNameColor,
          fontFamily: Constants.primaryFont,
          fontSize: 20,fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),),
        Text(' /$total',style: TextStyle(
          color: Constants.pageNameColor,
          fontFamily: Constants.primaryFont,
          fontSize: 14,fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,

        ),),
      ],
    );
  }
}
