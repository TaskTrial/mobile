import 'package:flutter/material.dart';
import 'package:task_trial/controllers/department_controller.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/departments_model.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/department/create_department_screen.dart';
import 'package:task_trial/views/department/single_department_screen.dart';

import 'edit_department_screen.dart';

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
        child: departmentsModel.departments!.isNotEmpty ?ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: departmentsModel.departments!.length,
          itemBuilder: (context, index) {
            final dept = departmentsModel.departments![index];
            return GestureDetector(
              onTap: () {
                print(dept);
                Get.to(()=>SingleDepartmentScreen(department: dept));
              },
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => _buildBottomSheet(context, dept),
                );
              },

              child: Container(
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
  Widget _buildBottomSheet(BuildContext context, Department dept) {
    final controller = Get.find<DepartmentController>();
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
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          _buildActionItem(
            icon: Icons.edit,
            label: 'Edit Department',
            color: Constants.primaryColor,
            onTap: () {
              Get.back();
              Get.to(() => EditDepartmentScreen(department: dept));
            },
          ),
          const SizedBox(height: 12),
          _buildActionItem(
            icon: Icons.delete,
            label: 'Delete Department',
            color: Colors.red,
            onTap: () {
              Get.back();
              _showDeleteConfirmation(context, dept.id!, controller);
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

  void _showDeleteConfirmation(BuildContext context, String deptId, DepartmentController controller) {
    Get.defaultDialog(
      title: "Delete Department",
      titleStyle: TextStyle(
        fontFamily: Constants.primaryFont,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      middleText: "Are you sure you want to delete this department?",
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
        controller.deleteDepartmentData(deptId: deptId);
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
