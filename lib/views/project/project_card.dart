import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/project_model.dart';
import 'package:task_trial/views/project/project_detail_screen.dart';

import '../../models/teams_model.dart';
import '../../utils/constants.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final Team team ;
  const ProjectCard({
    super.key, required this.project, required this.team,
  }) ;
  @override
  Widget build(BuildContext context) {
    Color color = Constants.getRandomProjectCardColor();
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               CircleAvatar(
                backgroundColor:Colors.white.withValues(alpha: 50),
                radius: 50,
                child: Icon(Icons.photo,size: 50,color:color,),  // Replace with your icon
                // Replace with your icon
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  print(team.members!.length);
                 Get.to(() => ProjectDetailScreen(project:project ,team: team)
                 );
                },
                child: CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.black,
                  child:  CircleAvatar(
                    radius: 22,
                    backgroundColor:color,
                    child:Transform.rotate(
                      angle: 45 * pi / 180, // Converts degrees to radians
                      child: Icon(Icons.arrow_upward, size: 23,color: Colors.black,),  // Replace with your actual widget
                    )
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            project.name!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                fontFamily: Constants.primaryFont),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Start Date  ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700,fontFamily: Constants.primaryFont)),

              const Icon(Icons.calendar_today, size: 16),
              const SizedBox(width: 5),
              Text(Constants.formatDate(date: project.startDate!),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500,fontFamily: Constants.primaryFont)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('End Date    ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700,fontFamily: Constants.primaryFont)),

              const Icon(Icons.calendar_today, size: 16),
              const SizedBox(width: 5),
              Text(Constants.formatDate(date: project.endDate!),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500,fontFamily: Constants.primaryFont)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Team          ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700,fontFamily: Constants.primaryFont)),

              const Icon(Icons.group, size: 16),
              const SizedBox(width: 5),
              Text(project.team!.name!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500,fontFamily: Constants.primaryFont)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            project.description!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600,fontFamily: Constants.primaryFont),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width:
                130, // You can adjust this depending on how many avatars
                height: 40,
                child:
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: List.generate(project.members!.length>4? 4:project.members!.length, (index) {
                          return Positioned(
                            left: index * 22.0,
                            child:
                            project.members![index].profilePic == null ||
                                project.members![index].profilePic == ""

                            ?
                                CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 17,
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.grey.withValues(alpha: 0.5),
                                  ),

                                )
                            :CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 17,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                    project.members![index].profilePic!
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    if (project.members!.length > 4)
                      Text('+${project.members!.length - 4}',
                          style: TextStyle(color: Colors.grey,
                              fontFamily: Constants.primaryFont,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),

                  ],
                )
                // Text(project.memberCount!=0?'Number of members :${project.memberCount}':'No team members found!'),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 90, // or use MediaQuery or make it responsive
                    child: LinearProgressIndicator(
                      value: project.progress!/ 100,
                      minHeight: 5,
                      backgroundColor: Colors.grey[300],
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('${project.progress} hours',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: Color(0xFF3E4ADE))),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}