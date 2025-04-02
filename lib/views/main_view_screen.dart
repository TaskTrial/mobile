import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/main_view_controller.dart';
import 'package:task_trial/utils/constants.dart';

class MainViewScreen extends StatelessWidget {
  const MainViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<MainViewController>(
        init: MainViewController(),
        builder: (controller) => Scaffold(
              appBar: _appBar(controller),
              body: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  children: controller.pages),
              bottomNavigationBar: _bottomNavigationBar(controller),
            ));
  }
  _appBar(MainViewController controller) {
    return AppBar(
      title: Text(controller.pageNames[controller.currentPageIndex.value]),
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Handle notification button press
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // Handle settings button press
          },
        ),
      ],
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
        height: 60,
        width: 60,
        child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset(
              iconPath,
              width: 30,
              height: 30,
            )),
      ),
      activeIcon: SizedBox(
        height: 60,
        width: 60,
        child: Image.asset(
          selectedIconPath,
        ),
      ),
      label: label,
    );
  }
}
