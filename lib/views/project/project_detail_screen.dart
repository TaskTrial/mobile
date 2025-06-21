import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/project_model.dart';
import 'package:task_trial/models/teams_model.dart';
import 'package:task_trial/services/project_services.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/project/edit_project_screen.dart';
import 'package:task_trial/views/project/task_item.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen(
      {super.key, required this.project, required this.team});
  final ProjectModel project;
  final Team team;

  @override
  Widget build(BuildContext context) {
    // ProjectDetailController controller = Get.put(ProjectDetailController(project: project));
    return Scaffold(
      backgroundColor: const Color(0xFFF0E3DA), // Background beige
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name!,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: Constants.primaryFont,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.description!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontFamily: Constants.primaryFont,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Assigned To
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Assigned to",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            const SizedBox(height: 8),
                            // Inside your Column (under "Assigned to")
                            _assignee()
                          ],
                        ),
                        // Due Date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Due date",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Constants.primaryFont)),
                            SizedBox(height: 8),
                            Text("Thursday, 20 July 2023",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: Constants.primaryFont)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    _priority(),
                    const SizedBox(height: 20),
                    _status(),
                    const SizedBox(height: 30),
                    Text(
                      'Tasks',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: Constants.primaryFont,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Tasks List
                    Expanded(
                      child: project.tasks!.isNotEmpty
                          ? ListView.builder(
                              itemCount: project.tasks!.length,
                              itemBuilder: (context, index) {
                                Task task = project.tasks![index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: TaskItem(
                                    title: task.title!,
                                    hours: Constants.formatDate(
                                        date: task.dueDate!),
                                  ),
                                );
                              },
                            )
                          : const Center(child: Text("No tasks found")),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _assignee() {
    return GestureDetector(
      onTap: _showAssigneesDialog,
      child: Container(
        width: 190,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(0.1), width: 2),
        ),
        child: Row(

          children: [
            Expanded(
              child: Stack(
                children: [
                  ...List.generate(
                      project.members!.length > 4 ? 4 : project.members!.length,
                      (index) {
                    return Positioned(
                      left: index * 22.0,
                      child: project.members![index].profilePic == null
                          ? CircleAvatar(
                              radius: 17,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundColor: Colors.orange,
                                radius: 15,
                                child: Icon(Icons.person,
                                    size: 30, color: Colors.white),
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 17,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                    project.members![index].profilePic!),
                              ),
                            ),
                    );
                  }),
                  if (project.members!.length > 4)
                    Positioned(
                      top: 4.5,
                      left: 4.5*22.0,
                      child: Text(
                        '+${project.members!.length - 4}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: Constants.primaryFont,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: _showAddMemberDialog,
                      child: CircleAvatar(
                        backgroundColor: Constants.primaryColor,
                        radius: 17,
                        child: Icon(Icons.add, size: 30, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _showAssigneesDialog() {
    final members = project.members ?? [];
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Project Members',
          style: TextStyle(
            fontFamily: Constants.primaryFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          width: 300,
          height: 400,
          child: ListView.separated(
            itemCount: members.length,
            separatorBuilder: (_, __) => Divider(height: 15),
            itemBuilder: (context, index) {
              final user = members[index];
              return ListTile(
                leading: user.profilePic != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic!),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.orange.withOpacity(0.3),
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                title: Text('${user.firstName} ${user.lastName}',
                    style: TextStyle(fontFamily: Constants.primaryFont)),
                subtitle: Text(user.role ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                trailing: IconButton(onPressed: (){
                  _confirmRemoveMemberDialog(members[index]);
                }, icon:
                    Icon(Icons.delete, color: Colors.red)),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Close',
              style: TextStyle(
                color: Constants.primaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: Constants.primaryFont,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants.primaryColor,
            ),
            onPressed: () {
              // Trigger add user logic
              // You can navigate to another screen or show a form
              // optionally close the dialog
              Get.back();
              _showAddMemberDialog();
            },
            child: Text(
              'Add Person',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddMemberDialog() {
    final members = team.members ?? [];
    String? projectId = project.id;
    String? role;
    Member? selectedMember;
    List<String> roles = [
      'PROJECT_OWNER',
      'MEMBER',
      'LEADER',
      'DEVELOPER',
      'TESTER',
      'DESIGNER'
    ];
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Assign Member To Project',
          style: TextStyle(
            fontFamily: Constants.primaryFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<Member>(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.white,
                  hint: Text('Select User'),
                  value: selectedMember,
                  isExpanded: true,
                  items: members
                      .where((member) =>
                          isProjectMember(project.members!, member.userId!) ==
                          false)
                      .map((member) => DropdownMenuItem<Member>(
                            value: member,
                            child: Row(
                              children: [
                                member.user!.profilePic != null
                                    ? CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.black,
                                        child: CircleAvatar(
                                          radius: 14,
                                          backgroundImage: NetworkImage(
                                              member.user!.profilePic!),
                                        ),
                                      )
                                    : const CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Color(0xFFFFE3C5),
                                        child: Icon(Icons.person,
                                            size: 15, color: Colors.white),
                                      ),
                                SizedBox(width: 10),
                                Text(
                                    '${member.user!.firstName} ${member.user!.lastName}'),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (Member? value) {
                    setState(() {
                      selectedMember = value;
                      role = null; // reset role if user changes
                    });
                  },
                ),
                if (selectedMember != null) ...[
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    isExpanded: true,
                    hint: Text('Select Role'),
                    value: role,
                    items: roles
                        .map((role) => DropdownMenuItem<String>(
                              value: role,
                              child: Text(role),
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        role = value;
                      });
                    },
                  ),
                ],
              ],
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
            onPressed: role != null && selectedMember != null
                ? null
                : () {
                    if (selectedMember != null && role != null) {
                      ProjectServices.addMember(
                        projectId: projectId!,
                        userId: selectedMember!.user!.id,
                        teamId: team.id!,
                        role: role!,
                      );
                      print(
                          'Selected User: ${selectedMember!.user!.firstName}, Role: $role');
                      Get.back();
                    }
                  },
            child: Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  _confirmRemoveMemberDialog(MemberModel member) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Confirm Removal',
          style: TextStyle(
            fontFamily: Constants.primaryFont,
            fontWeight: FontWeight.bold,
            color: Constants.primaryColor,
          ),
        ),
        content: Text(
            'Are you sure you want to remove ${member.firstName} from this Project ?'),
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
              ProjectServices.removeMember(userId: member.userId!, teamId: project.team!.id!, projectId: project.id!);
               Get.back();
            },
            child: Text(
              'Remove',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  bool isProjectMember(List<MemberModel> members, String userId) {
    for (var member in members) {
      if (member.userId == userId) {
        return true;
      }
    }
    return false;
  }

  _priority() {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 2),
      ),
      child: Row(
        children: [
          Icon(
            Icons.priority_high,
            color: project.priority == "HIGH"
                ? Colors.redAccent
                : project.priority == "MEDIUM"
                    ? Colors.orangeAccent
                    : Colors.green,
          ),
          const SizedBox(
            width: 5,
          ),
          Text("Task Priority    ",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold)),
          Text(project.priority!,
              style: TextStyle(
                  color: project.priority == "HIGH"
                      ? Colors.redAccent
                      : project.priority == "MEDIUM"
                          ? Colors.orangeAccent
                          : Colors.green,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  _status() {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 2),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: project.status == "ACTIVE"
                ? Colors.blue
                : project.status == "PLANNING"
                    ? Colors.orangeAccent
                    : project.status == "ON_HOLD"
                        ? Colors.purpleAccent
                        : project.status == "COMPLETED"
                            ? Colors.blueAccent
                            : Colors.redAccent,
          ),
          const SizedBox(
            width: 5,
          ),
          Text("Task Status    ",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold)),
          Text(project.status!,
              style: TextStyle(
                  color: project.status == "ACTIVE"
                      ? Colors.blue
                      : project.status == "PLANNING"
                          ? Colors.orangeAccent
                          : project.status == "ON_HOLD"
                              ? Colors.purpleAccent
                              : project.status == "COMPLETED"
                                  ? Colors.blueAccent
                                  : Colors.redAccent,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  _appBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.arrow_back))),
          const Text(
            "Project Detail",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Constants.pageNameColor,
              fontFamily: Constants.primaryFont,
            ),
          ),
          IconButton(
              onPressed: () {
                Get.to(() => EditProjectScreen(
                    project: project, teamId: project.team!.id!));
              },
              icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ))),
        ],
      ),
    );
  }
}
