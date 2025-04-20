import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_trial/controllers/department_controller.dart';
import 'package:task_trial/models/departments_model.dart';
import 'package:task_trial/models/organization_model.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/organization/edit_organization_screen.dart';

class SingleDepartmentScreen extends StatelessWidget {
   const SingleDepartmentScreen({super.key, required this.department});
  final Department department ;
  @override
  Widget build(BuildContext context) {

    DepartmentController controller =Get.put(DepartmentController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _appBar(),
              SizedBox(
                height: height * 0.05,
              ),
              _orgInfo(width, controller),
              SizedBox( height:  height * 0.02,),
              _ownersInfo(width),
            ],
          ),
        ),
      ),
    );
  }
  _appBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back)),
        ),

        Text(
          'My Department',
          style: TextStyle(
              color: Constants.pageNameColor,
              fontFamily: Constants.primaryFont,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        IconButton(onPressed: (){
          // Get.to(()=> EditOrganizationScreen(),
          //     arguments: org
          // );
        }, icon:
        CircleAvatar(
            backgroundColor: Constants.primaryColor,
            child: Icon(Icons.edit ,color: Colors.white,)
        )
        )
      ],
    );
  }
  Widget _infoRow(String label, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 90,
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 16,
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
  _orgInfo(double width,DepartmentController controller){
    return Container(
      padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _picturePart(controller),
          const SizedBox(height: 10),
          Text(
            department.name!,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            department.organization!.name!,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          _infoRow("Description", department.description!),
          _infoRow("Created at", Constants.formatDate(date: department.createdAt!)),
        ],
      ),
    );

  }
  _mangerRow(Manager manager){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          _ownerPic(
          ),
          SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${manager.firstName!} ${manager.lastName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: Constants.primaryFont,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
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
              Text( 'Manager',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: Constants.primaryFont,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 10),
           _mangerRow(department.manager!)
            ]
        )
    );
  }
  _picturePart(DepartmentController controller){
      return  CircleAvatar(
        radius: 40,
        backgroundColor: controller.getColorForDepartment(department.name!),
        child: Icon(controller.getIconForDepartment(department.name!), size: 50, color: Colors.white),
      );
  }
  _ownerPic(){
   return CircleAvatar(
        radius: 30,
        backgroundColor: Color(0xFFFFE3C5),
        child: Icon(Icons.person, size: 30, color: Colors.brown),
      );
  }



}
