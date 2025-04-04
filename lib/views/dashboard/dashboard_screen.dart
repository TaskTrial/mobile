import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/dashboard_controller.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/widgets/custom_drop_down_menu.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: 40, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _overallPart(),
                SizedBox(
                  height: 20,
                ),
                _tasksPart(),
                SizedBox(
                  height: 20,
                ),
                _projectsPart(),
              ],
            )));
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

  _taskRow(DashboardController controller, int index) {
    return Row(
      children: [
        Checkbox(
          value: controller.dashboardData[index]['check'],
          onChanged: (value) {
            controller.toggleCheck(index);
            value = controller.dashboardData[index]['check'];
          },
          activeColor: Constants.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(
          width: 240,
          child: Text(controller.dashboardData[index]['task'],
              style: TextStyle(
                color: Constants.pageNameColor,
                fontFamily: Constants.primaryFont,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          alignment: Alignment.center,
          width: 70,
          height: 30,
          decoration: controller.dashboardData[index]['status'] == 'Approved'
              ? BoxDecoration(
                  color: Colors.green.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30),
                )
              : controller.dashboardData[index]['status'] == 'In review'
                  ? BoxDecoration(
                      color: Colors.red.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30),
                    )
                  : BoxDecoration(
                      color: Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
          child: Text(controller.dashboardData[index]['status'],
              style: TextStyle(
                color: controller.dashboardData[index]['status'] == 'Approved'
                    ? Colors.green
                    : controller.dashboardData[index]['status'] == 'In review'
                        ? Colors.red
                        : Colors.orange,
                fontFamily: Constants.primaryFont,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
              )),
        )
      ],
    );
  }

  _tasksPart() {
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
            '    Today Tasks',
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
            builder: (controller) => SizedBox(
              height: 145,
              width: double.infinity,
              child: ListView.builder(
                itemCount: controller.dashboardData.length,
                itemBuilder: (context, index) {
                  return _taskRow(controller, index);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _projectRow({required DashboardController controller, required int index}) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
      child: Row(
        children: [
          SizedBox(
            width: 190,
            child: Text(controller.dashboardProjectsData[index]['name'],
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: Constants.primaryFont,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                )),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 80,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:  controller.dashboardProjectsData[index]
              ['status'] ==
                  'Completed'
                  ? Colors.green.withOpacity(0.3)
                  : controller.dashboardProjectsData[index]['status'] ==
                  'At risk'
                  ? Colors.red.withOpacity(0.3)
                  : controller.dashboardProjectsData[index]['status'] ==
                  'Delayed'
                  ? Colors.yellow.shade600.withOpacity(0.3)
                  : Colors.orange.withOpacity(0.3),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(controller.dashboardProjectsData[index]['status'],
                style: TextStyle(
                  color: controller.dashboardProjectsData[index]
                  ['status'] ==
                      'Completed'
                      ? Colors.green
                      : controller.dashboardProjectsData[index]['status'] ==
                      'At risk'
                      ? Colors.red
                      : controller.dashboardProjectsData[index]['status'] ==
                      'Delayed'
                      ? Colors.yellow.shade700
                      : Colors.orange,
                  fontFamily: Constants.primaryFont,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis,
                )),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: CircularPercentIndicator(
              radius: 22.0,
              lineWidth: 5.0,
              percent: double.parse(controller.dashboardProjectsData[index]
                      ['percentage']
                  .toString()),
              center: Text(
                  "${double.parse((controller.dashboardProjectsData[index]['percentage'] * 100).toString()).toInt()}%"),
              progressColor: controller.dashboardProjectsData[index]
                          ['status'] ==
                      'Completed'
                  ? Colors.green
                  : controller.dashboardProjectsData[index]['status'] ==
                          'At risk'
                      ? Colors.red
                      : controller.dashboardProjectsData[index]['status'] ==
                              'Delayed'
                          ? Colors.yellow.shade600
                          : Colors.orange,
            ),
          )
        ],
      ),
    );
  }

  _projectHeadRow() {
    return Row(
      children: [
        Container(
          width: 180,
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
          width: 10,
        ),
        Container(
          width: 80,
          child: Text('      Status',
              style: TextStyle(
                color: Colors.black,
                fontFamily: Constants.primaryFont,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis,
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 70,
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

  _projectsPart(){
    return Container(
      height: 230,
      width: double.infinity,
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
          _projectHeadRow(),
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
                          controller: controller, index: index);
                    },
                    itemCount: 4);
              },
            ),
          )
        ],
      ),
    );
  }
}
