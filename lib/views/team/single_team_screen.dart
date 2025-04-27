import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/team_controller.dart';
import 'package:task_trial/models/teams_model.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/team/edit_team_screen.dart';

class SingleTeamScreen extends StatelessWidget {
  const SingleTeamScreen({super.key, required this.team});
  final Team team ;
  @override
  Widget build(BuildContext context) {
    TeamController controller =Get.put(TeamController());
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
          'My Team',
          style: TextStyle(
              color: Constants.pageNameColor,
              fontFamily: Constants.primaryFont,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        IconButton(onPressed: (){
         Get.to(()=> EditTeamScreen(team: team));
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
  _orgInfo(double width,TeamController controller){
    return Container(
      padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _picturePart(),
          const SizedBox(height: 10),
          Text(
            team.name!,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _infoRow("Description", team.description??'There is no description'),
          _infoRow("Created at", Constants.formatDate(date: team.createdAt!)),
        ],
      ),
    );

  }
  _creatorRow(Team team){
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
                    Text("${team.creator!.firstName!} ${team.creator!.lastName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: Constants.primaryFont,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      team.creator!.email!,
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
              Text( 'Creator',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: Constants.primaryFont,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 10),
              _creatorRow(team)
            ]
        )
    );
  }
  _picturePart(){
   if( team.avatar == null || team.avatar!.isEmpty) {
     return CircleAvatar(
       radius: 40,
       backgroundColor: Colors.orangeAccent.withOpacity(0.5),
       child: Icon(Icons.people, size: 50, color: Colors.white),
     );
   }
   return CircleAvatar(
     radius: 40,
     backgroundColor: Colors.white,
     child: CircleAvatar(
       radius: 38,
       backgroundImage: NetworkImage(team.avatar!),
     ),
   );

  }
  _ownerPic(){
    if( team.avatar != null && team.avatar!.isNotEmpty) {
      return CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(team.creator!.profilePic!),
        ),
      );

    }
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.orangeAccent.withOpacity(0.5),
      child: Icon(Icons.people, size: 30, color: Colors.white),
    );


  }



}
