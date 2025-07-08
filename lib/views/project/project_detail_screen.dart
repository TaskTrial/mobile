import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/project_model.dart';
import 'package:task_trial/models/teams_model.dart';
import 'package:task_trial/services/project_services.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/chat/chat_screen.dart';
import 'package:task_trial/views/main_view_screen.dart';
import 'package:task_trial/views/project/edit_project_screen.dart';
import 'package:task_trial/views/project/task_item.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen(
      {super.key, required this.project, required this.team});
  final ProjectModel project;
  final Team team;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // ProjectDetailController controller = Get.put(ProjectDetailController(project: project));
    String aiMessage= """
Project Overview:
📌 **${project.name!.trim()}** is a project focused on ${project.description!.trim()}.
🔄 It is currently in the **${project.status!.trim()}** phase with a **${project.priority}** priority level.
👥 Assigned to **${project.memberCount}** team members.
📅 Deadline: **${project.endDate}**.
🧩 Number of tasks: **${project.tasks!.length}**.
📝 Task list: ${project.tasks!.map((task) => task.title!).join(', ')}.

 A💬 Feel free to ask me anything about this project — I’m here to help you analyze, plan, or improve it.
 --> 
""";
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
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth * 0.5,
                              child: Text(
                                project.name!,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Constants.primaryFont,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "AI Assistant   ",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                fontFamily: Constants.primaryFont,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() =>
                                ChatScreen(initialMessage: aiMessage
                                ,)
                                );
                              },
                              child: CircleAvatar(
                                radius: 23,
                                backgroundColor: Constants.primaryColor,
                                child: const CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.rocket_launch_outlined, size: 23, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
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
                        // Remove `Expanded`, use fixed height or wrap in `ShrinkWrappingScrollView`
                        project.tasks!.isNotEmpty
                            ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: project.tasks!.length,
                          itemBuilder: (context, index) {
                            Task task = project.tasks![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: TaskItem(
                                title: task.title!,
                                hours: Constants.formatDate(date: task.dueDate!),
                              ),
                            );
                          },
                        )
                            : const Center(child: Text("No tasks found")),
                      ],
                    ),
                  )

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
                  // Show up to 4 avatars
                  ...List.generate(
                    project.memberCount! > 4 ? 4 : project.memberCount!,
                    (index) {
                      print('project.members:');
                      project.members?.forEach((m) => print('${m.firstName} ${m.lastName}'));
                      print('Count: ${project.members?.length}');

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
                                      size: 16, color: Colors.white),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 17,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundImage: NetworkImage(
                                    project.members![index].profilePic!,
                                  ),
                                ),
                              ),
                      );
                    },
                  ),

                  // +X indicator
                  if (project.memberCount! > 4)
                    Positioned(
                      left: 4 * 22.0,
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey.shade400,
                          child: Text(
                            '+${project.memberCount! - 4}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: Constants.primaryFont,
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Add button on the far right
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: _showAddMemberDialog,
                      child: CircleAvatar(
                        backgroundColor: Constants.primaryColor,
                        radius: 17,
                        child: Icon(Icons.add, size: 20, color: Colors.white),
                      ),
                    ),
                  ),
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
                trailing: user.userId != CacheHelper().getData(key: 'id')
                    ? IconButton(
                        onPressed: () {
                          _confirmRemoveMemberDialog(members[index]);
                        },
                        icon: Icon(Icons.delete, color: Colors.red))
                    : const SizedBox.shrink(),
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
    String? teamId = team.id;
    List<String> roles = [
      'PROJECT_OWNER',
      'MEMBER',
      'LEADER',
      'DEVELOPER',
      'TESTER',
      'DESIGNER'
    ];

    Map<Member, String?> selectedMembersWithRoles = {};
    TextEditingController searchController = TextEditingController();
    String searchQuery = '';

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Assign Members To Project',
          style: TextStyle(
            fontFamily: Constants.primaryFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            List<Member> filteredMembers = members
                .where((member) =>
                    isProjectMember(project.members!, member.userId!) ==
                        false &&
                    ('${member.user?.firstName ?? ''} ${member.user?.lastName ?? ''}')
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                .toList();

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search Bar
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name...',
                      prefixIcon: Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Constants.primaryColor,
                          width: 1,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  //  Member List with Checkboxes and Roles
                  ...filteredMembers.map((member) {
                    final isSelected =
                        selectedMembersWithRoles.containsKey(member);
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
                                    selectedMembersWithRoles[member] = null;
                                  } else {
                                    selectedMembersWithRoles.remove(member);
                                  }
                                });
                              },
                            ),
                            if (member.user?.profilePic != null)
                              CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                    NetworkImage(member.user!.profilePic!),
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
                                '${member.user?.firstName ?? ''} ${member.user?.lastName ?? ''}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        if (isSelected)
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, bottom: 10),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text('Select Role'),
                              value: selectedMembersWithRoles[member],
                              items: roles
                                  .map((role) => DropdownMenuItem<String>(
                                        value: role,
                                        child: Text(role),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedMembersWithRoles[member] = value;
                                });
                              },
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ],
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
              final validMembers = selectedMembersWithRoles.entries
                  .where((entry) => entry.value != null)
                  .map((entry) => {
                        "userId": entry.key.userId!,
                        "role": entry.value!,
                      })
                  .toList();

              if (validMembers.isNotEmpty) {
                ProjectServices.addMembers(
                  projectId: projectId!,
                  teamId: teamId!,
                  userRoles: validMembers,
                );
                print('Added project members: $validMembers');
                Get.back();
              } else {
                Get.snackbar(
                    "Validation", "Please select roles for selected members.");
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
              ProjectServices.removeMember(
                  userId: member.userId!,
                  teamId: project.team!.id!,
                  projectId: project.id!);
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
          Text("Project Priority    ",
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
          Text("Project Status    ",
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
