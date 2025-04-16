import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/utils/constants.dart';

class MyOrganizationScreen extends StatelessWidget {
  const MyOrganizationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.arrow_back)),
                  ),
                  SizedBox(
                    width: width * 0.1,
                  ),
                  Text(
                    'My Organization',
                    style: TextStyle(
                        color: Constants.pageNameColor,
                        fontFamily: Constants.primaryFont,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              _orgInfo(width),
              SizedBox( height:  height * 0.02,),
              _ownersInfo(width),


            ],
          ),
        ),
      ),
    );
  }
  Widget _infoRow(String label, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 80,
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: Constants.primaryFont,
                      color: Colors.black,
                      fontWeight: FontWeight.w700))),
          const SizedBox(width: 10),
          Expanded(
              child:
              Text(content, style:
              TextStyle(
                  fontSize: 16,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87))),
        ],
      ),
    );
  }
  _orgInfo(double width){
    return Container(
      padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFFFFE3C5),
            child: Icon(Icons.account_balance_rounded,
                size: 50, color: Colors.brown),
          ),
          const SizedBox(height: 10),
          Text(
            "Youssef Inc",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Software",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          _infoRow("Contact Email", "youssef@gmail.com"),
          _infoRow("Phone", "+212 6 01 02 03 04"),
          _infoRow("Address", "Rabat, Morocco"),
          _infoRow("Created By", 'Youssef Fathy')

        ],
      ),
    );

  }
  _ownerRow(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFFFFE3C5),
              child: Icon(Icons.account_balance_rounded,)
          ),
          SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Youssef Fathy',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: Constants.primaryFont,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                    Text('youssef@gmail.com',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: Constants.primaryFont,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ]
              )
          )
        ],
      ),
    );
  }
  _ownersInfo(double width){
    return Container(
        padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( 'Owners',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: Constants.primaryFont,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 10),
              ...List.generate(3, (index) {
                return _ownerRow();
              },)
            ]
        )
    );
  }

}
