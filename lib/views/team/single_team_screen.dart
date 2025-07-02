import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/team_controller.dart';
import 'package:task_trial/models/organization_model.dart';
import 'package:task_trial/models/teams_model.dart';
import 'package:task_trial/services/team_services.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/team/edit_team_screen.dart';

import '../../services/organization_services.dart';
class SingleTeamScreen extends StatelessWidget {
  const SingleTeamScreen({super.key, required this.team, required this.organization});
  final Team team ;
  final OrganizationModel organization ;
  @override
  Widget build(BuildContext context) {
    TeamController controller =Get.put(TeamController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0,left: 20,right: 20),
              child: _appBar(),
            ),
            // Fixed at top
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.01),
                    _orgInfo(width, controller),
                    SizedBox(height: height * 0.02),
                    _ownersInfo(width),
                    SizedBox(height: height * 0.02),
                    _membersInfo(width, team.members!),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
  Widget _appBar(){
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
  Widget _orgInfo(double width,TeamController controller){
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
  Widget _creatorRow(Team team){
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
  Widget _ownersInfo(double width){
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
  Widget _picturePart(){
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
  Widget _ownerPic(){
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

  _membersInfo(double width, List<Member> members) {
    return Container(
        padding:
        const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(
                'Members',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: Constants.primaryFont,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
              Spacer(),
              isOwnerOrLeader(organization.owners! ,team.members!)?
              IconButton(
                  onPressed: (){
                _showAddOwnerDialog(organization);
              }, icon:
              CircleAvatar(
                  backgroundColor: Constants.primaryColor,
                  child: Icon(Icons.add ,color: Colors.white,)
              )
              ):
                  SizedBox()

            ],
          ),
          SizedBox(height: 10),
          if (members.isEmpty || members.length == 1 && members[0].userId == team.creator!.id)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Center(
                child: Text(
                  'No members in this team',
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: Constants.primaryFont,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          else
          ...List.generate(
            members.length,
                (index) {
              if(members[index].userId != team.creator!.id) {
                return _memberRow(members[index]);
              }
              return const SizedBox.shrink();
            },
          )
        ]));
  }
  _memberRow(Member member) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          _userPic(member),
          SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${member.user!.firstName!} ${member.user!.lastName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: Constants.primaryFont,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      member.role!,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: Constants.primaryFont,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      member.user!.email!,
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: Constants.primaryFont,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),

                  ])),
          if (isOwnerOrLeader(organization.owners!, team.members!))
            IconButton(
              onPressed: () {
               _confirmRemoveMemberDialog(member);
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
            // PopupMenuButton<String>(
            //   icon: Icon(Icons.more_vert, color: Colors.black54),
            //   onSelected: (String value) {
            //     if (value == 'remove') {
            //       TeamServices.removeMember(
            //       userId: member.userId!,
            //       teamId: team.id!
            //       );
            //     }
            //   },
            //   itemBuilder: (BuildContext context) => [
            //     PopupMenuItem<String>(
            //       value: 'remove',
            //       child: Text('Remove from Team'),
            //     ),
            //   ],
            // ),
        ],
      ),
    );
  }
  _userPic(Member member) {
    if (member.user!.profilePic != null) {
      return CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(member.user!.profilePic!),
        ),
      );
    } else {
      return const CircleAvatar(
        radius: 30,
        backgroundColor: Color(0xFFFFE3C5),
        child: Icon(Icons.person, size: 30, color: Colors.white),
      );
    }
  }
  void _showAddOwnerDialog(OrganizationModel org) {
    final users = org.users ?? [];
    String? teamId = team.id;
    Map<User, String?> selectedUsersWithRoles = {};
    List<String> roles = ['MEMBER', 'LEADER'];
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Select Users to Add as Team Members',
          style: TextStyle(
            fontFamily: Constants.primaryFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: users
                    .where((user) =>
                user.isOwner != true &&
                    isTeamMember(team.members!, user.id!) == false)
                    .map((user) {
                  final isSelected = selectedUsersWithRoles.containsKey(user);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  selectedUsersWithRoles[user] = null;
                                } else {
                                  selectedUsersWithRoles.remove(user);
                                }
                              });
                            },
                          ),
                          if (user.profilePic != null)
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(user.profilePic!),
                            )
                          else
                            const CircleAvatar(
                              radius: 15,
                              backgroundColor: Color(0xFFFFE3C5),
                              child: Icon(Icons.person,
                                  size: 15, color: Colors.white),
                            ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${user.firstName} ${user.lastName}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      if (isSelected)
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text('Select Role'),
                            value: selectedUsersWithRoles[user],
                            items: roles
                                .map((role) => DropdownMenuItem<String>(
                              value: role,
                              child: Text(role),
                            ))
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                selectedUsersWithRoles[user] = value;
                              });
                            },
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Constants.primaryColor,
                fontFamily: Constants.primaryFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants.primaryColor,
            ),
            onPressed: () {
              final validUsers = selectedUsersWithRoles.entries
                  .where((entry) => entry.value != null)
                  .map((entry) => {
                "userId": entry.key.id!,
                "role": entry.value!,
              })
                  .toList();

              if (validUsers.isNotEmpty) {
                TeamServices.addMembers(
                  teamId: teamId!,
                  users: validUsers,
                );
                print('Added users: $validUsers');
                Get.back();
              } else {
                Constants.alertSnackBar(title: 'Validation', message: 'Please select roles for selected users.');
              }
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  _confirmRemoveMemberDialog(Member member) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Confirm Removal' ,
          style: TextStyle(
            fontFamily: Constants.primaryFont,
            fontWeight: FontWeight.bold,
            color: Constants.primaryColor,
          ),
        ),
        content: Text('Are you sure you want to remove ${member.user!.firstName} from this team?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel' ,
              style: TextStyle(
                color: Constants.primaryColor,
                fontFamily: Constants.primaryFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants.primaryColor,
            ),
            onPressed: () {
              TeamServices.removeMember(userId: member.userId!, teamId: team.id!);
              Get.back();
            },
            child: Text('Remove' ,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }


  bool isOwnerOrLeader(List<Owner> owners ,List<Member> members) {
    String? userId = CacheHelper().getData(key: 'id');
    for (var owner in owners) {
      if (owner.id == userId) {
        return true;
      }
    }
    for (var member in members) {
      if (member.userId == userId && (member.role == 'LEADER')) {
        return true;
      }
    }
    return false;
  }

  bool isTeamMember(List<Member> members ,String userId) {
    for (var member in members) {
      if (member.userId == userId) {
        return true;
      }
    }
    return false;
  }







}
