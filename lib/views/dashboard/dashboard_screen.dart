import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/dashboard_controller.dart';
import 'package:task_trial/models/project_model.dart';
import 'package:task_trial/models/task_model.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/widgets/custom_drop_down_menu.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.tasks, required this.projects});
  final List<TaskModel> tasks ;
  final List<ProjectModel> projects ;

  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
     double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: SingleChildScrollView(
          child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, top: 40, bottom: 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _overallPart(),
                    SizedBox(
                      height: 20,
                    ),
                    _tasksPart(screenWidth),
                    SizedBox(
                      height: 20,
                    ),
                    _projectsPart(width: screenWidth),
                  ],
                ),
              )),
        ));
  }

  _overallPart() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Overall',
              style: TextStyle(
                  fontFamily: Constants.primaryFont,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            CustomDropDownMenu()
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _overallCard(
                imageName: "revenue.png",
                percentage: '12%',
                title: 'Total revenue',
                amount: Text(
                  '\$53,009899',
                  style: TextStyle(
                    color: Constants.pageNameColor,
                    fontFamily: Constants.primaryFont,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              _overallCard(
                  imageName: "projects.png",
                  percentage: '20%',
                  title: 'Projects',
                  amount: _amount(amount: '95', total: '100')),
              SizedBox(
                width: 10,
              ),
              _overallCard(
                  imageName: "timeSpent.png",
                  percentage: '15%',
                  title: 'Time spent',
                  amount: _amount(amount: '1022', total: '1300 Hrs')),
              SizedBox(
                width: 10,
              ),
              _overallCard(
                  imageName: "resources.png",
                  percentage: '02%',
                  title: 'Resources',
                  amount: _amount(amount: '101', total: '120')),
            ],
          ),
        )
      ],
    );
  }

  _overallCard(
      {required String imageName,
      required String title,
      required String percentage,
      required Widget amount}) {
    return Container(
      width: 150,
      height: 110,
      decoration: BoxDecoration(
        color: Constants.transparentWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "${Constants.imagesPath}$imageName",
                    width: 45,
                    height: 45,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: Constants.pageNameColor,
                            fontFamily: Constants.primaryFont,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_up_outlined,
                            color: Colors.green,
                          ),
                          Text(
                            percentage,
                            style: TextStyle(
                                color: Constants.pageNameColor,
                                fontFamily: Constants.primaryFont,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  )
                ]),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: double.infinity,
            child: amount,
            // child: Text('\$53,009899',style: TextStyle(
            //   color: Constants.pageNameColor,
            //     fontFamily: Constants.primaryFont,
            //     fontSize: 20,fontWeight: FontWeight.bold,
            //   overflow: TextOverflow.ellipsis,
            //
            // ),),
          )
        ],
      ),
    );
  }

  _amount({required String amount, required String total}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          amount,
          style: TextStyle(
            color: Colors.black,
            fontFamily: Constants.primaryFont,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          ' /$total',
          style: TextStyle(
            color: Colors.black,
            fontFamily: Constants.primaryFont,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  _taskRow(DashboardController controller, int index,TaskModel task,double width) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.03,vertical: width*0.015),
      child: Row(
        children: [
          // Checkbox(
          //   value: controller.dashboardData[index]['check'],
          //   onChanged: (value) {
          //     controller.toggleCheck(index);
          //     value = controller.dashboardData[index]['check'];
          //   },
          //   activeColor: Constants.primaryColor,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(50),
          //   ),
          // ),
          SizedBox(
            width: width*0.5,
            child: Text(task.title!,
                style: TextStyle(
                  color: Constants.pageNameColor,
                  fontFamily: Constants.primaryFont,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis,
                )),
          ),
          Spacer(),
          Container(
            alignment: Alignment.center,
            width: width*0.25,
            height: 30,
            decoration:task.status == 'DONE'
                ? BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                  )
                : task.status == 'TODO'
                    ? BoxDecoration(
                        color: Colors.red.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                      )
                : task.status == 'REVIEW'
                ? BoxDecoration(
              color: Colors.purpleAccent.withOpacity(0.3),
              borderRadius: BorderRadius.circular(30),
            )
                : BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
                      ),
            child: Text(task.status!,
                style: TextStyle(
                  color: task.status == 'DONE'
                      ? Colors.green
                      : task.status == 'TODO'
                          ? Colors.red
                          : task.status=='REVIEW'?Colors.purpleAccent:Colors.orange,
                  fontFamily: Constants.primaryFont,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis,
                )),
          ),
        ],
      ),
    );
  }

  _tasksPart(double width) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 0, right: 5, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Constants.transparentWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '    Tasks Summary',
            style: TextStyle(
                color: Constants.pageNameColor,
                fontFamily: Constants.primaryFont,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          GetBuilder<DashboardController>(
            init: DashboardController(),
            builder: (controller) =>
                SizedBox(
              height: 145,
              width: double.infinity,
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return _taskRow(controller,index,tasks[index],width);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _projectRow({required DashboardController controller, required int index ,required double width ,required ProjectModel project}) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
      child: Row(
        children: [
          SizedBox(
            width: width*0.47,
            child: Text(project.name!,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: Constants.primaryFont,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                )),
          ),

          Container(
            width: width*0.2,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:  project.status ==
                  'COMPLETED'
                  ? Colors.green.withOpacity(0.3)
                  : project.status ==
                  'CANCELLED'
                  ? Colors.red.withOpacity(0.3)
                  :  project.status==
                  'PLANNING'
                  ? Colors.orange.shade600.withOpacity(0.3):
                   project.status ==
                  'ACTIVE'
                  ? Colors.blue.shade600.withOpacity(0.3)
                  : Colors.purple.withOpacity(0.3),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(project.status!,
                style: TextStyle(
                  color: project.status ==
                      'COMPLETED'
                      ? Colors.green
                      : project.status ==
                      'CANCELLED'
                      ? Colors.red
                      :  project.status==
                      'PLANNING'
                      ? Colors.orange:
                  project.status ==
                      'ACTIVE'
                      ? Colors.blue
                      : Colors.purple,
                  fontFamily: Constants.primaryFont,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis,
                )),
          ),
      Spacer(),
          Container(

            width: width*0.19,
            alignment: Alignment.center,
            child: CircularPercentIndicator(
              radius: 22.0,
              lineWidth: 5.0,
              percent: project.progress!.toDouble()/100,
              center: Text(
                  "${project.progress}%"),
              progressColor:project.status ==
                  'COMPLETED'
                  ? Colors.green
                  : project.status ==
                  'CANCELLED'
                  ? Colors.red
                  :  project.status==
                  'PLANNING'
                  ? Colors.orange:
              project.status ==
                  'ACTIVE'
                  ? Colors.blue
                  : Colors.purple,
            ),
          )
        ],
      ),
    );
  }

  _projectHeadRow({required double width}) {
    return Row(
      children: [
        Container(
          width: width*0.5,
          child: Text('Name',
              style: TextStyle(
                color: Colors.black,
                fontFamily: Constants.primaryFont,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis,
              )),
        ),
        SizedBox(
          width: width*0.2,
          child: Text('Status',
              style: TextStyle(
                color: Colors.black,
                fontFamily: Constants.primaryFont,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis,
              )),
        ),
        Container(
          width: width*0.16,
          child: Text(' Progress',
              style: TextStyle(
                color: Colors.black,
                fontFamily: Constants.primaryFont,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis,
              )),
        )
      ],
    );
  }

  _projectsPart({required double width }){
    return Container(
      height: 230,
      width: width,
      padding: const EdgeInsets.only(
          left: 10, right: 5, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Constants.transparentWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '   Projects Summary',
            style: TextStyle(
                color: Constants.pageNameColor,
                fontFamily: Constants.primaryFont,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          _projectHeadRow(width: width),
          SizedBox(
            height: 10,
          ),
          // projects  ------>
          SizedBox(
            height: 145,
            child: GetBuilder<DashboardController>(
              builder: (controller) {
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return _projectRow(
                          controller: controller, index: index, width: width,project: projects[index]
                      );
                    },
                    itemCount: projects.length);
              },
            ),
          )
        ],
      ),
    );
  }
}
