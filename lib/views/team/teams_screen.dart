import 'package:flutter/material.dart';
import 'package:task_trial/controllers/department_controller.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/departments_model.dart';
import 'package:task_trial/models/teams_model.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/department/create_department_screen.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key, required this.teamsModel});
  final TeamsModel teamsModel ;
  @override
  Widget build(BuildContext context) {
    const double avatarRadius = 16;
    const double overlap = 8;
    final double avatarDiameter = avatarRadius * 2; // 32
    final double step = avatarDiameter - overlap; // 24
    return Scaffold(
      floatingActionButton:FloatingActionButton(
        onPressed: () {
          Get.to(CreateDepartmentScreen(organizationId:CacheHelper().getData(key: 'orgId')));
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
        child: teamsModel.data!.teams!.isNotEmpty?ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: teamsModel.data!.teams!.length,
          itemBuilder: (context, index) {
            final team = teamsModel.data!.teams![index];
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
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFFFC1B3),
                    child: Icon(
                        Icons.people_alt,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
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
                        // dept.isEmpty?Container():
                        // SizedBox(
                        //   width:
                        //       avatarDiameter + (dept.members.length - 1) * step,
                        //   height: avatarDiameter,
                        //   child: Stack(
                        //     children: dept.members.asMap().entries.map((entry) {
                        //       final i = entry.key;
                        //       final url = entry.value;
                        //       return Positioned(
                        //         left: i * step,
                        //         child: CircleAvatar(
                        //           radius: avatarRadius,
                        //           backgroundImage: NetworkImage(url),
                        //         ),
                        //       );
                        //     }).toList(),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // Task count
                  // Text(
                  //   '${dept.manager!.firstName}',
                  //   style: const TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 16,
                  //   ),
                  // ),
                ],
              ),
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
}
