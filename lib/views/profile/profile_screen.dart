import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/profile_controller.dart';
import 'package:task_trial/models/user_model.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/auth/login_screen.dart';
import 'package:intl/intl.dart';
import 'package:task_trial/views/main_view_screen.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Constants.backgroundColor,
          appBar: _appBar(),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                     _picturePart(controller),
                      const SizedBox(height: 10),
                      Text(
                        "${controller.userModel.user!.firstName} ${controller.userModel.user!.lastName}",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${(controller.userModel.user!.jobTitle) == null ? "@" : ""}${(controller.userModel.user!.jobTitle) ?? (controller.userModel.user!.username)}",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      _infoRow("Email", "${controller.userModel.user!.email}"),
                      _infoRow("Phone", "${(controller.userModel.user!.phoneNumber)?? "Not Available"}"),
                      _infoRow("Bio",
                          "${(controller.userModel.user!.bio) == null ? "Not Available" : controller.userModel.user!.bio}"),
                      _infoRow("Join At", DateFormat('MMM d, y').format(DateTime.parse(controller.userModel.user!.createdAt!))),

                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _menuItem(
                    icon: Icons.edit,
                    title: "Edit Profile",
                    onTap: () {
                      Get.to(
                        () => EditProfileScreen(),
                        arguments: controller.userModel
                      );
                    }),
                _menuItem(
                    icon: Icons.settings, title: "Settings", onTap: () {}),
                _menuItem(
                    icon: Icons.check_circle_outline,
                    title: "Terms of Service",
                    onTap: () {}),
                _menuItem(
                    icon: Icons.logout,
                    title: "Logout",
                    onTap: () {
                      Get.dialog(
                        AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text("Logout",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: Constants.primaryFont,
                                  fontWeight: FontWeight.bold,
                                  color: Constants.pageNameColor)),
                          content:
                              const Text("Are you sure you want to logout?",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Constants.pageNameColor,
                                    fontFamily: Constants.primaryFont,
                                    )),
                          actions: [
                            TextButton(
                              onPressed: () {
                                controller.logout();
                              },
                              child: const Text("Yes",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Constants.primaryColor,
                                      fontFamily: Constants.primaryFont)),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("No",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Constants.primaryColor,
                                      fontFamily: Constants.primaryFont)),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Get.offAll(
            () =>  MainViewScreen(),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 300),
          );
        },
      ),
      centerTitle: true,
      title: const Text(
        "Profile",
        style: TextStyle(
          color: Constants.pageNameColor,
          fontFamily: Constants.primaryFont,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Constants.backgroundColor,
    );
  }
  _picturePart(ProfileController  controller){
   if (controller.userModel.user!.profilePic != null) {
      return CircleAvatar(
        radius: 45,
        backgroundColor:Colors.black,
        child: CircleAvatar(
          radius: 43,
          backgroundImage: NetworkImage(controller.userModel.user!.profilePic!),
        ),
      );
    } else {
      return const CircleAvatar(
        radius: 40,
        backgroundColor: Color(0xFFFFE3C5),
        child: Icon(Icons.person, size: 50, color: Colors.brown),
      );
    }
  }

  Widget _infoRow(String label, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 60,
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w600))),
          const SizedBox(width: 10),
          Expanded(
              child:
                  Text(content, style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }

  Widget _menuItem(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
  
}
