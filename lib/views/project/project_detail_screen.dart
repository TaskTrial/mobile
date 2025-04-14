import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/project/project_controller.dart';
import 'package:task_trial/controllers/project/project_detail_controller.dart';
import 'package:task_trial/controllers/task_controller.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/project/task_item.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key,required this.project,required this.teamImages});
  final Project project;
  final List<String> teamImages ;
  @override
  Widget build(BuildContext context) {
    ProjectDetailController controller = Get.put(ProjectDetailController(project: project));
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
                      project.title,
                      style:
                          TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: Constants.primaryFont,

                          ),
                    ),
                    const SizedBox(height: 8),
                     Text(
                      project.description,
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
                            SizedBox(
                              width: 120, // You can adjust this depending on how many avatars
                              height: 40,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: List.generate(teamImages.length>4?4:teamImages.length, (index) {
                                        return Positioned(
                                          left: index * 22.0,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 17,
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundImage: NetworkImage(teamImages[index]),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  if (teamImages.length > 4)
                                    Text('+${teamImages.length - 4}',
                                        style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Due Date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Due date",
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: Constants.primaryFont)),
                            SizedBox(height: 8),
                            Text("Thursday, 20 July 2023",
                                style: TextStyle(color: Colors.black,
                                    fontFamily: Constants.primaryFont)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Tasks List
                    Expanded(
                      child: ListView.builder(
                          itemCount: controller.tasks.length,
                          itemBuilder: (context, index) {
                            Task task = controller.tasks[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: TaskItem(
                                  title: task.title,
                                  hours: task.timeAgo,
                                  avatars: controller.getUserImagesByTaskId(task.id) ,
                              ),
                            );
                          }, )
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
  _appBar(){
    return   Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
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
          const SizedBox(width: 60),
          const Text(
            "Project Detail",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Constants.pageNameColor,
              fontFamily: Constants.primaryFont,
            ),
          ),
        ],
      ),
    );
  }
}


