import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/task/task_controller.dart';
import 'package:task_trial/models/project_model.dart';
import 'package:task_trial/models/task_model.dart';
import 'package:task_trial/views/task/edit_task_screen.dart';
import 'package:task_trial/views/task/task_detail_screen.dart';

import '../../utils/constants.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key, required this.tasks, required this.projects});
  final List<TaskModel> tasks;
  final List<ProjectModel> projects;

  @override
  Widget build(BuildContext context) {
    final colors = [
      Color(0xff0DA6C2).withOpacity(0.2),
      Color(0xffB404FF).withOpacity(0.2),
      Color(0xffFFC239).withOpacity(0.3),
      Color(0xff31EA10).withOpacity(0.3),
      Color(0xffce9696).withOpacity(0.2),
    ];
    final TaskController controller = Get.put(TaskController());
    controller.setTasks(tasks);
    controller.setProjects(projects);
    return GetX<TaskController>(
        init: TaskController(),
        builder: (controller) => Scaffold(
              backgroundColor: Constants.backgroundColor,
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _filter(controller),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilter("All", controller.allCount, 0,
                              controller, colors[0]),
                          const SizedBox(width: 8),
                          _buildFilter("To Do", controller.todoCount, 1,
                              controller, colors[1]),
                          const SizedBox(width: 8),
                          _buildFilter(
                              "In Progress",
                              controller.inProgressCount,
                              2,
                              controller,
                              colors[2]),
                          const SizedBox(width: 8),
                          _buildFilter("In Review", controller.inReviewCount,
                              4, controller, colors[4]),
                          const SizedBox(width: 8),
                          _buildFilter("Completed", controller.completedCount,
                              3, controller, colors[3]),

                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: tasks.isEmpty?Center(
                        child: Text('No Tasks Found',style: TextStyle(
                          color: Constants.pageNameColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: Constants.primaryFont,
                        ),),
                      ):Obx(() =>
                          ListView.builder(
                            itemCount: controller.filteredTasks.length,
                            itemBuilder: (context, index) {
                              final task = controller.filteredTasks[index];
                              return _buildTaskCard(context,task);
                            },
                          )),
                    )
                  ],
                ),
              ),
            ));
  }

  Widget _buildFilter(String label, int count, int index,
      TaskController controller, Color color) {
    final isSelected = controller.selectedFilterIndex.value == index;
    final colors = [
      Color(0xff0DA6C2).withOpacity(0.5),
      Color(0xffB404FF).withOpacity(0.5),
      Color(0xffFFC239).withOpacity(0.7),
      Color(0xff31EA10).withOpacity(0.6),
      Color(0xffce9696).withOpacity(0.6),
    ];
    return GestureDetector(
      onTap: () => controller.changeFilter(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colors[index] : color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          "$label",
          style: TextStyle(
            color: isSelected ? Colors.white : Constants.pageNameColor,
            fontSize: 14,
            fontFamily: Constants.primaryFont,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context,TaskModel task) {
    final TaskController controller =Get.find();
    controller.getTeamId(task.project!.id!);
    String teamId=controller.getTeamId(task.project!.id!);
    final colors = [
      Color(0xff0DA6C2),
      Color(0xffB404FF),
      Color(0xffFFC239),
      Color(0xff31EA10),
      Color(0xffce9696),
    ];
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => _buildBottomSheet(context, task , teamId),
        );
      },
      onTap: (){
        print(teamId);
        Get.to(()=>TaskDetailScreen(task: task,teamId:teamId ,));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 90),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 4,
                backgroundColor: task.status == 'TODO'
                    ? colors[1]
                    : task.status == 'IN_PROGRESS'
                        ? colors[2]
                        : task.status == 'DONE'
                            ? colors[3] : task.status == 'REVIEW'? colors[4]
                            : colors[0]),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(task.title!,
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 6),
                Text(Constants.formatDate(date: task.dueDate!), style: const TextStyle(fontSize: 12)),
                const Spacer(),
                SizedBox(
                  width:
                  122, // You can adjust this depending on how many avatars
                  height: 35,
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: List.generate(3, (index) {
                            return Positioned(
                              right: index * 22.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 17,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.orangeAccent.withOpacity(0.5),
                                  child: Icon(Icons.person,color: Colors.white,),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _filter(TaskController controller) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              fontSize: 16,
              fontFamily: Constants.primaryFont,
              fontWeight: FontWeight.w600,
              color: Constants.pageNameColor,
            ),
          ),
          Text(
            "${controller.filteredTasks.length}",
            style: TextStyle(
              fontSize: 16,
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
    );
  }

  Widget _buildBottomSheet(BuildContext context, TaskModel task,String teamId) {
    final controller = Get.find<TaskController>();
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
            label: 'Edit Task',
            color: Constants.primaryColor,
            onTap: () {
              Get.back();
              Get.to(() => EditTaskScreen(task: task,teamId: teamId,));
            },
          ),
          const SizedBox(height: 12),
          _buildActionItem(
            icon: Icons.delete,
            label: 'Delete Task',
            color: Colors.red,
            onTap: () {
              Get.back();
              _showDeleteConfirmation(context, teamId, task.project!.id!, task.id!, controller);
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
  void _showDeleteConfirmation(BuildContext context,String teamId, String projId, String taskId,TaskController controller) {
    Get.defaultDialog(
      title: "Delete Task",
      titleStyle: TextStyle(
        fontFamily: Constants.primaryFont,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      middleText: "Are you sure you want to delete this Task?",
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
       controller.deleteTaskData(teamId: teamId, projectId: projId, taskId: taskId);
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
