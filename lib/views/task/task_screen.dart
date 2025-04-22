import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/task/task_controller.dart';

import '../../utils/constants.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Color(0xff0DA6C2).withOpacity(0.2),
      Color(0xffB404FF).withOpacity(0.2),
      Color(0xffFFC239).withOpacity(0.3),
      Color(0xff31EA10).withOpacity(0.3),
    ];

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
                          _buildFilter("Completed", controller.completedCount,
                              3, controller, colors[3]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: Obx(() => ListView.builder(
                            itemCount: controller.filteredTasks.length,
                            itemBuilder: (context, index) {
                              final task = controller.filteredTasks[index];
                              return _buildTaskCard(task);
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
          "$label $count",
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

  Widget _buildTaskCard(Task task) {
    final colors = [
      Color(0xff0DA6C2),
      Color(0xffB404FF),
      Color(0xffFFC239),
      Color(0xff31EA10),
    ];
    return Container(
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
              backgroundColor: task.status == TaskStatus.todo
                  ? colors[1]
                  : task.status == TaskStatus.inProgress
                      ? colors[2]
                      : task.status == TaskStatus.completed
                          ? colors[3]
                          : colors[0]),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(task.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 10),
              const Icon(Icons.calendar_today, size: 16),
              const SizedBox(width: 6),
              Text(task.timeAgo, style: const TextStyle(fontSize: 12)),
              const Spacer(),
              SizedBox(
                width:
                122, // You can adjust this depending on how many avatars
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: List.generate(task.assignees.length>4? 4:task.assignees.length, (index) {
                          return Positioned(
                            right: index * 22.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 17,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                    task.assignees[index].imageUrl),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    if (task.assignees.length > 4)
                      Text('+${task.assignees.length - 4}',
                          style: TextStyle(color: Colors.grey,
                              fontFamily: Constants.primaryFont,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),


                  ],
                ),
              ),
            ],
          ),
        ],
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
}
