import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/project/project_controller.dart';
import 'package:task_trial/controllers/task/task_controller.dart';
import 'package:task_trial/models/project_model.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/project/project_card.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key, required this.projects});
  final List<ProjectModel> projects;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProjectController());
    int size = projects.length;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            // AppBar
           _filter(),
            SizedBox(height: 10),
            Expanded(
              child: size==0?Center(
                        child:  Text('No Projects !'
                          ,style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color:Constants.pageNameColor,
                            fontFamily: Constants.primaryFont,
                          ),

                        ),
                      ):
                    ListView.builder(
                      itemCount: size,
                      itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
                            child: ProjectCard(
                              project: projects[index],

                            ),
                          );

                      },
                    ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
  _filter(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
                fontSize:16,
                fontFamily: Constants.primaryFont,
                fontWeight: FontWeight.w600,
                color: Constants.pageNameColor,
              ),
            ),
            Text(
              " 3",
              style: TextStyle(
                fontSize:16,
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
      ),
    );
  }
}


