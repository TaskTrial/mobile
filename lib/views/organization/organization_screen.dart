import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_trial/models/organization_model.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/organization/edit_organization_screen.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key});
    @override
  Widget build(BuildContext context) {
      final OrganizationModel org = Get.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _appBar(org),
              SizedBox(
                height: height * 0.05,
              ),
              _orgInfo(width,org: org),
              SizedBox( height:  height * 0.02,),
              _ownersInfo(width, org.owners!),
            ],
          ),
        ),
      ),
    );
  }
  _appBar( OrganizationModel org){
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
            'My Organization',
            style: TextStyle(
                color: Constants.pageNameColor,
                fontFamily: Constants.primaryFont,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          IconButton(onPressed: (){
            Get.to(()=> EditOrganizationScreen(),
             arguments: org
            );
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
  _orgInfo(double width,{required OrganizationModel org}){
    return Container(
      padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _picturePart(org),
          const SizedBox(height: 10),
          Text(
            org.name!,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            org.industry!,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          _infoRow("Contact Email", org.contactEmail??'null'),
          _infoRow("Phone", org.contactPhone.toString()),
          _infoRow("Address", org.address.toString()),
          _infoRow("Created At",
              DateFormat('MMM d, y').format(DateTime.parse(
                  org.createdAt!))),
          _infoRow('Size Range',  org.sizeRange! ),
          _infoRow('Website', org.website??'Null'),
        ],
      ),
    );

  }
  _ownerRow(Owner owner){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          _ownerPic(owner),
          SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(owner.name!,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: Constants.primaryFont,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(owner.email!,
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
  _ownersInfo(double width,List<Owner> owners){
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
              ...List.generate(owners.length, (index) {
                return _ownerRow(owners[index]);
              },)
            ]
        )
    );
  }
  _picturePart(OrganizationModel org){
    if (org.logoUrl != null && org.logoUrl!.trim().isNotEmpty) {
      return CircleAvatar(
        radius: 45,
        backgroundColor:Colors.black,
        child: CircleAvatar(
          radius: 43,
          backgroundImage: NetworkImage(org.logoUrl!),
        ),
      );
    } else {
      return const CircleAvatar(
        radius: 40,
        backgroundColor: Color(0xFFFFE3C5),
        child: Icon(Icons.account_balance_rounded, size: 50, color: Colors.brown),
      );
    }
  }
  _ownerPic(Owner owner){
    if (owner.profileImage != null) {
      return CircleAvatar(
        radius: 30,
        backgroundColor:Colors.black,
        child: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(owner.profileImage!),
        ),
      );
    } else {
      return const CircleAvatar(
        radius: 30,
        backgroundColor: Color(0xFFFFE3C5),
        child: Icon(Icons.person, size: 30, color: Colors.brown),
      );
    }
  }



}
