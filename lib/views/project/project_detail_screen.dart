import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/project/task_item.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0E3DA), // Background beige
      body: SafeArea(
        child: Column(
          children: [
            // Header
           _appBar(),
            // White card with rounded top corners
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
                    const Text(
                      "Fintech Mobile App UI",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Fintech app development provides more freedom to banking and other financial institutions.",
                      style: TextStyle(color: Colors.grey),
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
                              width:
                                  120, // You can adjust this depending on how many avatars
                              height: 40,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: List.generate(4, (index) {
                                        return Positioned(
                                          left: index * 22.0,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 17,
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundImage: NetworkImage(
                                                  "https://randomuser.me/api/portraits/men/$index.jpg"),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  Text('+3',
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
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            SizedBox(height: 8),
                            Text("Thursday, 20 July 2023",
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Tasks List
                    Expanded(
                      child: ListView(
                        children: const [
                          TaskItem(
                            title: "Create Design System",
                            hours: "25 hr",
                            avatars: [
                              "https://randomuser.me/api/portraits/men/1.jpg",
                              "https://randomuser.me/api/portraits/men/1.jpg",
                              "https://randomuser.me/api/portraits/men/1.jpg"
                            ],
                          ),
                          SizedBox(height: 16),
                          TaskItem(
                            title: "Create Wireframe",
                            hours: "18 hr",
                            avatars: [
                              "https://randomuser.me/api/portraits/men/1.jpg",
                              "https://randomuser.me/api/portraits/men/2.jpg",
                              "https://randomuser.me/api/portraits/men/7.jpg",
                              "https://randomuser.me/api/portraits/men/4.jpg",
                              "https://randomuser.me/api/portraits/men/5.jpg",
                              "https://randomuser.me/api/portraits/men/6.jpg"
                            ],
                          ),
                          SizedBox(height: 16),
                          TaskItem(
                            title: "Landing Page Design",
                            hours: "8 hr",
                            avatars: [
                              "https://randomuser.me/api/portraits/men/1.jpg",
                              "https://randomuser.me/api/portraits/men/2.jpg",
                              "https://randomuser.me/api/portraits/men/7.jpg",
                              "https://randomuser.me/api/portraits/men/4.jpg",
                              "https://randomuser.me/api/portraits/men/5.jpg",
                              "https://randomuser.me/api/portraits/men/6.jpg"
                            ],
                          ),
                        ],
                      ),
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


