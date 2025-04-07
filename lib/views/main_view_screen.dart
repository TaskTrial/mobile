import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/main_view_controller.dart';
import 'package:task_trial/models/login_model.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/profile/profile_screen.dart';

class MainViewScreen extends StatelessWidget {
   const MainViewScreen({super.key});


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GetX<MainViewController>(
        init: MainViewController(),
        builder: (controller) => !controller.isLoading.value?Scaffold(
              backgroundColor: Constants.backgroundColor,
              floatingActionButton: controller.currentPageIndex.value == 0 ||
                      controller.currentPageIndex.value == 1
                  ? _floatingActionButton(controller)
                  : null,
              appBar: _appBar(controller),
              body: Container(
                width: screenWidth,
                height: screenHeight,
                color: Constants.backgroundColor,
                child: PageView(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    children: controller.pages),
              ),
              bottomNavigationBar: _bottomNavigationBar(controller),
            ): Scaffold(
              backgroundColor: Constants.backgroundColor,
              body: Center(
                child: CircularProgressIndicator(
                  color: Constants.primaryColor,
                ),
              ),
        )
    );
  }
  _appBar(MainViewController controller) {
    return AppBar(
      title: Text(
        controller.pageNames[controller.currentPageIndex.value],
        style: TextStyle(
            color: Constants.pageNameColor,
            fontFamily: Constants.primaryFont,
            fontSize: 26,
            fontWeight: FontWeight.bold),
      ),
      backgroundColor: Constants.backgroundColor,
      actions: [
        IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: const Text('Notification'),
                  content: const Text('You have new notifications!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back(); // Close the dialog
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(
                '${Constants.imagesPath}notification_true.png',
                width: 30,
                height: 30,
              ),
            )),
     SizedBox(width: 10,),
     GestureDetector(
        onTap: () {
          print(controller.userModel.user!.toJson());
          Get.to(
            () =>  ProfileScreen(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500),
            arguments: controller.userModel,
          );
        },
       child: CircleAvatar(
         radius: 19,
          backgroundColor: Colors.white,
         child: SizedBox(
            height: 35,
            width: 35,
           child: CircleAvatar(
             backgroundImage: const AssetImage(
               '${Constants.imagesPath}pic.png',
             ),
             radius: 30,
             backgroundColor: Colors.grey.withOpacity(0.5),
           ),
         ),
       ),
     ),
        SizedBox(width: 20,)
      ],
    );
  }
  _floatingActionButton(MainViewController controller) {
    return FloatingActionButton(
      onPressed: () {
        Get.dialog(
          AlertDialog(
            title: const Text('Add New Project'),
            content:
            const Text('Do you want to add a new project?'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                },
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: Constants.primaryColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
    );
  }
  _bottomNavigationBar(MainViewController controller) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: controller.currentPageIndex.value,
      onTap: controller.onTapped,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.black,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        _bottomNavigationBarItem('${Constants.tabsPath}dashboard.png',
            '${Constants.tabsPath}selectedDashboard.png', 'Dashboard'),
        _bottomNavigationBarItem('${Constants.tabsPath}project.png',
            '${Constants.tabsPath}selectedProject.png', 'Projects'),
        _bottomNavigationBarItem('${Constants.tabsPath}chat.png',
            '${Constants.tabsPath}selectedChat.png', 'Chat'),
        _bottomNavigationBarItem('${Constants.tabsPath}task.png',
            '${Constants.tabsPath}selectedTask.png', 'Tasks'),
        _bottomNavigationBarItem('${Constants.tabsPath}more.png',
            '${Constants.tabsPath}selectedMore.png', 'More'),
      ],
    );
  }
  _bottomNavigationBarItem(
      String iconPath, String selectedIconPath, String label) {
    return BottomNavigationBarItem(
      icon: SizedBox(
        height: 50,
        width: 50,
        child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset(
              iconPath,
              width: 25,
              height: 25,
            )),
      ),
      activeIcon: SizedBox(
        height: 50,
        width: 50,
        child: Image.asset(
          selectedIconPath,
        ),
      ),
      label: label,
    );
  }
}
