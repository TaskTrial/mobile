import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/project/project_controller.dart';
import 'package:task_trial/models/project_model.dart';
import 'package:task_trial/models/teams_model.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/project/edit_project_screen.dart';
import 'package:task_trial/views/project/project_card.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key, required this.projects, required this.teams});
  final List<ProjectModel> projects;
  final List<Team> teams ;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProjectController());
    int size = projects.length;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            // AppBar
           _filter(),
            SizedBox(height: 10),
            Expanded(
              child: size==0?Center(
                        child:  Text('No Projects Found !'
                          ,style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color:Constants.pageNameColor,
                            fontFamily: Constants.primaryFont,
                          ),

                        ),
                      ):
                    ListView.builder(
                      itemCount: size,
                      itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
                            child: GestureDetector(
                              onLongPress: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  builder: (_) => _buildBottomSheet(context, projects[index]),
                                );
                              },
                              child: ProjectCard(
                                project: projects[index],
                                team: getTeamById(projects[index].team!.id!),
                              ),
                            ),
                          );

                      },
                    ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
  _filter(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
          color: Constants.transparentWhite,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Result :",
              style: TextStyle(
                fontSize:16,
                fontFamily: Constants.primaryFont,
                fontWeight: FontWeight.w600,
                color: Constants.pageNameColor,
              ),
            ),
            Text(
              ' ${projects.length.toString() ?? '0'}',
              style: TextStyle(
                fontSize:16,
                fontFamily: Constants.primaryFont,
                fontWeight: FontWeight.w600,
                color: Constants.pageNameColor,
              ),
            ),
            Spacer(),
            GestureDetector(child: Icon(Icons.sort)),
            SizedBox(width: 14),
            GestureDetector(child: Icon(Icons.filter_list_alt)),


          ],
        ),
      ),
    );
  }
  Widget _buildBottomSheet(BuildContext context, ProjectModel project) {
    final controller = Get.find<ProjectController>();
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
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          _buildActionItem(
            icon: Icons.edit,
            label: 'Edit Project',
            color: Constants.primaryColor,
            onTap: () {
              Get.back();
              Get.to(() => EditProjectScreen(project: project,teamId: project.team!.id!,));
            },
          ),
          const SizedBox(height: 12),
          _buildActionItem(
            icon: Icons.delete,
            label: 'Delete Project',
            color: Colors.red,
            onTap: () {
              Get.back();
              _showDeleteConfirmation(context, project.team!.id!,project.id!, controller);
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

  void _showDeleteConfirmation(BuildContext context,String teamId, String projId, ProjectController controller) {
    Get.defaultDialog(
      title: "Delete Department",
      titleStyle: TextStyle(
        fontFamily: Constants.primaryFont,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      middleText: "Are you sure you want to delete this project?",
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
       controller.deleteProjectData(teamId: teamId, projectId: projId);
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

  // get team by team id
 Team getTeamById(String teamId) {
    // return team
    return teams.firstWhere((team) => team.id == teamId, orElse: () => Team(id: teamId, name: 'Unknown Team', members: []));

  }

}


