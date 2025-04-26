import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_trial/controllers/profile/profile_controller.dart';
import 'package:task_trial/models/user_model.dart';
import 'package:task_trial/utils/cache_helper.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/views/profile/profile_screen.dart';
import 'package:task_trial/widgets/edit_photo_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Constants.backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("Edit Profile",
                style: TextStyle(
                    color: Constants.pageNameColor,
                    fontSize: 24,
                    fontFamily: Constants.primaryFont,
                    fontWeight: FontWeight.bold)),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Get.back();
                // Go back to the previous screen
              },
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  _profileImage(controller),
                  SizedBox(
                    height: 20,
                  ),
                  _editProfileImage(controller),
                  const SizedBox(height: 20),
                  _buildInputField(
                    "First Name",
                    controller.firstNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'First Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildInputField(
                    "Last Name",
                    controller.lastNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Last Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildInputField(
                    "Job Title",
                    controller.jobTitleController,
                  ),
                  const SizedBox(height: 15),
                  _buildInputField("Phone", controller.phoneNumberController),
                  const SizedBox(height: 15),
                  _buildInputField("Bio", controller.bioController,
                      maxLines: 3, maxLength: 100),
                  const SizedBox(height: 30),
                  _buildButtons(controller)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _profileImage(ProfileController controller) {
    return Center(
      child: controller.profileImage == null &&
              controller.userModel.user!.profilePic == null
          ? CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFFFE3C5),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            )
          : controller.profileImage == null &&
                  controller.userModel.user!.profilePic != null
              ? CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage:
                        NetworkImage(controller.userModel.user!.profilePic!),
                  ),
                )
              : CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage:
                        FileImage(File(controller.profileImage!.path)),
                  ),
                ),
    );
  }
  _editProfileImage(ProfileController controller) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EditPhotoButton(
          icon: Icons.upload,
          color: Constants.primaryColor,
          onPressed: () {
            ImagePicker()
                .pickImage(source: ImageSource.gallery)
                .then((value) {
              if (value != null) {
                print(value.name);
                controller.uploadProfileImage(value);
              }
            });
          },
        ),
        EditPhotoButton(
          icon: Icons.delete,
          color: Colors.red,
          onPressed: () {
            if (controller.profileImage != null) {
              controller
                  .deleteProfileImage(controller.profileImage!);
            }
          },
        ),
        EditPhotoButton(
          icon: Icons.check,
          color: Colors.green.withOpacity(0.9),
          onPressed: () {
            if (controller.profileImage != null) {
              controller.updateProfilePicture(
                  File(controller.profileImage!.path));
            }
            else{
              Constants.errorSnackBar(title: 'Failed', message: 'Please select an image');
            }
          },
        ),
      ],
    );
  }
  Widget _buildInputField(String label, TextEditingController controller,
      {int maxLines = 1,
      String? Function(String?)? validator,
      int? maxLength}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: Constants.primaryFont)),
        const SizedBox(height: 6),
        TextFormField(
          maxLength: maxLength,
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: '$label is Empty!',
            hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontFamily: Constants.primaryFont),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
  _buildButtons(ProfileController controller) {
    return ElevatedButton(
      onPressed: () {
        if (controller.formKey.currentState!.validate()) {
          controller.updateProfileData();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.primaryColor,
        padding: const EdgeInsets.symmetric(
            horizontal: 40, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: const Text("Save Changes",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: Constants.primaryFont)),
    );
  }
}
