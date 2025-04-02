import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/views/chat/chat_screen.dart';
import 'package:task_trial/views/dashboard/dashboard_screen.dart';
import 'package:task_trial/views/more/more_screen.dart';
import 'package:task_trial/views/profile/profile_screen.dart';
import 'package:task_trial/views/project/project_screen.dart';
import 'package:task_trial/views/task/task_screen.dart';
class MainViewController extends GetxController {
  var currentPageIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);
  List<Widget> pages = [
    DashboardScreen(),
    ProjectScreen(),
    ChatScreen(),
    TaskScreen(),
    MoreScreen()
  ];
  List<String> pageNames = [
    'Dashboard',
    'Projects',
    'Chat',
    'Tasks',
    'More'
  ];

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPageIndex.value = pageController.page!.round();
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
  void onTapped(int index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onPageTapped(int index) {
    pageController.jumpToPage(index);
  }
  void onPageSwiped(int index) {
    currentPageIndex.value = index;
  }
  void onPageChanged(int index) {
    currentPageIndex.value = index;
  }
  void onPageScroll(int index) {
    currentPageIndex.value = index;
  }
  void onPageScrollEnd(int index) {
    currentPageIndex.value = index;
  }


}