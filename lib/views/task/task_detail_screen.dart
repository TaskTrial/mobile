import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/project/project_detail_controller.dart';
import 'package:task_trial/controllers/task/task_controller.dart';
import 'package:task_trial/models/project_model.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/project/edit_project_screen.dart';
import 'package:task_trial/views/project/task_item.dart';

import '../../models/task_model.dart';
import 'edit_task_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key,required this.task, required this.teamId});
  final TaskModel task;
  final String teamId;
  @override
  Widget build(BuildContext context) {

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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title??'No title',
                        style:
                        TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: Constants.primaryFont,
                  
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        task.description??'No description',
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
                                child:
                                // teamImages.isNotEmpty || teamImages!= null ?
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: Stack(
                                //         children: List.generate(teamImages.length>4?4:teamImages.length, (index) {
                                //           return Positioned(
                                //             left: index * 22.0,
                                //             child: CircleAvatar(
                                //               backgroundColor: Colors.white,
                                //               radius: 17,
                                //               child: CircleAvatar(
                                //                 radius: 15,
                                //                 backgroundImage: NetworkImage(teamImages[index]),
                                //               ),
                                //             ),
                                //           );
                                //         }),
                                //       ),
                                //     ),
                                //     if (teamImages.length > 4)
                                //       Text('+${teamImages.length - 4}',
                                //           style: TextStyle(color: Colors.grey)),
                                //   ],
                                // )
                                //     :
                                const Center(child: Text("No team members found")),
                              ),
                            ],
                          ),
                          // Due Date
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text("Due date",
                                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: Constants.primaryFont)),
                              SizedBox(height: 8),
                              Text( Constants.formatDate(date: task.dueDate!),
                                  style: TextStyle(color: Colors.black,
                                      fontFamily: Constants.primaryFont)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      _priority(),
                      const SizedBox(height: 15),
                      _status(),
                      const SizedBox(height: 15),
                      _project(),
                      const SizedBox(height: 15),
                      _createdBy(),
                      const SizedBox(height: 15),
                      (task.labels != null && task.labels!.isNotEmpty) ? _labels(task.labels!) : SizedBox(),
                      const SizedBox(height: 30),
                      Text('Subtasks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: Constants.primaryFont,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Tasks List
                      (task.subtasks != null && task.subtasks!.isNotEmpty)
                          ? Column(
                        children: task.subtasks!.map((subtask) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: TaskItem(
                              title: subtask.title ?? 'Untitled',
                              hours: Constants.formatDate(date: subtask.dueDate!),
                            ),
                          );
                        }).toList(),
                      )
                          : const Center(child: Text("No subtasks found")),
                    ],
                  ),
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
                  child: Icon(Icons.arrow_back))
          ),
          const Text(
            "Task Detail",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Constants.pageNameColor,
              fontFamily: Constants.primaryFont,
            ),
          ),
          IconButton(
              onPressed: () {
               Get.to(()=> EditTaskScreen(task: task,teamId: teamId,) );
              },
              icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color:Constants.primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.edit , color: Colors.white,))
          ),

        ],
      ),
    );
  }
  _priority(){
    return Container(
      padding: const EdgeInsets.only(top: 15,bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.1),width: 2),
      ),
      child: Row(
        children: [
          Icon(Icons.priority_high, color:
            task.priority == "HIGH"
                ? Colors.redAccent
                : task.priority == "MEDIUM"
                ? Colors.orangeAccent
                :
          Colors.green,),
          const SizedBox(width: 5,),
          Text("Task Priority    ",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold)),
          Text(task.priority!,
              style: TextStyle(
                  color:
                  task.priority == "HIGH"
                      ? Colors.redAccent
                      : task.priority == "MEDIUM"
                      ? Colors.orangeAccent
                      :
                  Colors.green
                  ,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
  _status(){
    return Container(
      padding: const EdgeInsets.only(top: 15,bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.1),width: 2),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color:
          task.status == "DONE"
              ? Colors.green
              : task.status == "IN_PROGRESS"
              ? Colors.orangeAccent
              : task.status == "TODO"? Colors.redAccent:
               Colors.black,
          ),
          const SizedBox(width: 5,),
          Text("Task Status    ",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold)),
          Text(task.status!,
              style: TextStyle(
                  color:
                  task.status == "DONE"
                      ? Colors.green
                      : task.status == "IN_PROGRESS"
                      ? Colors.orangeAccent
                      : task.status == "TODO"? Colors.redAccent:
                  Colors.black,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
  _project(){
    return Container(
      padding: const EdgeInsets.only(top: 15,bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.1),width: 2),
      ),
      child: Row(
        children: [
          Icon(Icons.work, color:
          Constants.primaryColor
          ),
          const SizedBox(width: 5,),
          Text("Project            ",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold)),
          Text(task.project!.name!,
              style: TextStyle(
                  color:
                  Colors.black,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
  _createdBy(){
    return Container(
      padding: const EdgeInsets.only(top: 15,bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.1),width: 2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.person, color:
              Constants.primaryColor
              ),
              const SizedBox(width: 5,),
              Text("Created By",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: Constants.primaryFont,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              (task.creator!.profilePic!=null && task.creator!.profilePic!.isNotEmpty)?
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(task.creator!.profilePic!),
                  ):
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Constants.primaryColor.withOpacity(0.5),
                    child: Icon(Icons.person,color: Colors.white,),
                  ),
              const SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${task.creator!.firstName!} ${task.creator!.lastName!}',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: Constants.primaryFont,
                          fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
  Widget _labels(List<String> labels) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.label, color: Constants.primaryColor),
              const SizedBox(width: 5),
              Text(
                "Labels",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: labels.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns
              childAspectRatio: 3, // Width to height ratio
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Constants.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  labels[index],
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontFamily: Constants.primaryFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }




}


