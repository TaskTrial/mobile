import 'package:flutter/material.dart';
import 'package:task_trial/controllers/department_controller.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/departments_model.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/department/create_department_screen.dart';

class DepartmentsScreen extends StatelessWidget {
  const DepartmentsScreen({super.key, required this.departmentsModel});
  final DepartmentsModel departmentsModel ;
  @override
  Widget build(BuildContext context) {
    DepartmentController controller = Get.put(DepartmentController());
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
          'Departments',
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
        child: departmentsModel.departments!.isNotEmpty?ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: departmentsModel.departments!.length,
          itemBuilder: (context, index) {
            final dept = departmentsModel.departments![index];
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
                    backgroundColor: controller.getColorForDepartment(dept.name!),
                    child: Icon(
                      controller.getIconForDepartment(dept.name!),
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
                          dept.name!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.primaryFont,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dept.description!,
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
                              Constants.formatDate(date: dept.createdAt!),
                              style: TextStyle(
                                fontFamily: Constants.primaryFont,
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox( height: 2,),
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
                            Text(
                              '${dept.manager!.firstName} ${dept.manager!.lastName}',
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
        ):Center(child: Text('No Departments Found'
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
