import 'package:flutter/material.dart';
import 'package:task_trial/controllers/department_controller.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/team_controller.dart';
import 'package:task_trial/models/departments_model.dart';
import 'package:task_trial/models/organization_model.dart';
import 'package:task_trial/models/teams_model.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/department/create_department_screen.dart';
import 'package:task_trial/views/team/create_team_screen.dart';
import 'package:task_trial/views/team/edit_team_screen.dart';
import 'package:task_trial/views/team/single_team_screen.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key, required this.teamsModel, required this.organizationModel});
  final TeamsModel teamsModel ;
  final OrganizationModel organizationModel;
  @override
  Widget build(BuildContext context) {
    const double avatarRadius = 16;
    const double overlap = 8;
    final double avatarDiameter = avatarRadius * 2; // 32
    final double step = avatarDiameter - overlap; // 24
    TeamController teamsController = Get.put(TeamController());
    return Scaffold(
      floatingActionButton:FloatingActionButton(
        onPressed: () {
          Get.to(()=>CreateTeamScreen(organizationId: CacheHelper().getData(key: 'orgId')));
        },
        backgroundColor: Constants.primaryColor,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: CircleAvatar(
              backgroundColor: Colors.white, child: Icon(Icons.arrow_back)),
        ),
        title: Text(
          'Teams',
          style: TextStyle(
            fontFamily: Constants.primaryFont,
            color: Constants.pageNameColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25,bottom: 10),
        child: (teamsModel.data != null && teamsModel.data!.teams!.isNotEmpty)?ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: teamsModel.data!.teams!.length,
          itemBuilder: (context, index) {
            final team = teamsModel.data!.teams![index];
            return GestureDetector(
              onTap: (){
                Get.to(()=>SingleTeamScreen(team: team,organization: organizationModel,));
              },
                onLongPress: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (_) => _buildBottomSheet(context, team),
                  );
                },
              child: _teamCard(team)
            );
          },
        ):Center(child: Text('No Teams Found'
          ,style: TextStyle(
            fontFamily: Constants.primaryFont,
            color: Constants.pageNameColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
  _teamCard(Team team){
   return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          // Icon + colored circle
          _teamAvatar(team),
          const SizedBox(width: 16),
          // Texts + overlapping avatars
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team.name!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: Constants.primaryFont,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  team.description ?? 'No description',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: Constants.primaryFont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text('Created at : ' ,
                      style: TextStyle(
                        fontFamily: Constants.primaryFont,
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      Constants.formatDate(date: team.createdAt!),
                      style: TextStyle(
                        fontFamily: Constants.primaryFont,
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox( height: 5,),
                Row(
                  children: [
                    Text('Created by : ' ,
                      style: TextStyle(
                        fontFamily: Constants.primaryFont,
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5,),
                    (team.creator?.profilePic != null && team.creator!.profilePic!.isNotEmpty)? CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        team.creator!.profilePic!,
                      ),
                    ): Container(),
                    SizedBox(width: 5,),
                    Text(
                      '${team.creator!.firstName} ${team.creator!.lastName}',
                      style: TextStyle(
                        fontFamily: Constants.primaryFont,
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  _teamAvatar(Team team){
    if(team.avatar != null && team.avatar!.isNotEmpty){
      return CircleAvatar(
        radius: 28,
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
          team.avatar!,
        ),
      );
    }
    return CircleAvatar(
      radius: 28,
      backgroundColor: Color(0xFFFFC1B3),
      child: Icon(
        Icons.people_alt,
        color: Colors.white,
        size: 28,
      ),
    );

  }

  Widget _buildBottomSheet(BuildContext context, Team team) {
    final controller = Get.find<TeamController>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Constants.backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 150,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 10,),
          _buildActionItem(
            icon: Icons.edit,
            label: 'Edit Team',
            color: Constants.primaryColor,
            onTap: () {
              Get.back();
              Get.to(()=> EditTeamScreen(team: team));
            },
          ),
          const SizedBox(height: 12),
          _buildActionItem(
            icon: Icons.delete,
            label: 'Delete Team',
            color: Colors.red,
            onTap: () {
              Get.back();
               _showDeleteConfirmation(context, team.id!, controller);
            },
          ),
          const SizedBox(height: 12),
          _buildActionItem(
            icon: Icons.close,
            label: 'Cancel',
            color: Colors.grey,
            onTap: () => Get.back(),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String teamId, TeamController controller) {
    Get.defaultDialog(
      title: "Delete Team",
      titleStyle: TextStyle(
        fontFamily: Constants.primaryFont,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      middleText: "Are you sure you want to delete this team?",
      middleTextStyle: TextStyle(
        fontFamily: Constants.primaryFont,
        fontSize: 16,
      ),
      textCancel: "Cancel",
      textConfirm: "Delete",
      confirmTextColor: Colors.white,
      cancelTextColor: Constants.primaryColor,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
        controller.deleteTeamData(teamId: teamId);
      },
    );
  }
  Widget _buildActionItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontFamily: Constants.primaryFont,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            )
          ],
        ),
      ),
    );
  }

}
