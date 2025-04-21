import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_trial/controllers/team_controller.dart';
import 'package:task_trial/models/teams_model.dart';

import '../../utils/constants.dart';
import '../../widgets/edit_photo_button.dart';
class EditTeamScreen extends StatelessWidget {
  EditTeamScreen({super.key, required this.team});
  final Team team;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: team.name);
    TextEditingController descriptionController = TextEditingController(text: team.description);
    final teamController = Get.put(TeamController());
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text('Edit Team',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: Constants.primaryFont
            )
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GetBuilder<TeamController>(
                      builder:(controller) {
                        return _profileImage(controller);
                      }, ),
                  const SizedBox(height: 16),
                  _editProfileImage(teamController),
                  SizedBox( height: 26),
                  _buildInputField('Name', nameController,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a team name';
                        }
                        return null;
                      }),
                  const SizedBox(height: 16),
                  _buildInputField("Description",descriptionController
                      ,
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a team description';
                        }
                        return null;
                      },
                      maxLength: 200
                  ),
                  const SizedBox(height: 16),
                  _buildButtons(teamController, team.id!, nameController, descriptionController)
                ]
            ),
          )
      ),
    );
  }

  _profileImage(TeamController controller) {
    return Center(
      child: controller.teamAvatar == null &&
          (team.avatar == null ||
             team.avatar!.trim().isEmpty)
          ? CircleAvatar(
        radius: 50,
        backgroundColor: Color(0xFFFFE3C5),
        child: Icon(Icons.people,
            size: 50, color: Colors.white),
      )
          : controller.teamAvatar == null &&
          (team.avatar != null &&
              team.avatar!.trim().isNotEmpty)
          ? CircleAvatar(
        radius: 50,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          radius: 48,
          backgroundImage: NetworkImage(team.avatar!),
        ),
      )
          : CircleAvatar(
        radius: 50,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          radius: 48,
          backgroundImage:
          FileImage(File(controller.teamAvatar!.path)),
        ),
      ),
    );
  }
  _editProfileImage(TeamController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EditPhotoButton(
          icon: Icons.upload,
          color: Constants.primaryColor,
          onPressed: () {
            ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
              if (value != null) {
                print(value.name);
                controller.uploadLogoImage(value);
              }
            });
          },
        ),
        EditPhotoButton(
          icon: Icons.delete,
          color: Colors.red,
          onPressed: () {
            if (controller.teamAvatar != null) {
              controller.deleteLogoImage(controller.teamAvatar!);
            }
          },
        ),
        EditPhotoButton(
          icon: Icons.check,
          color: Colors.green.withOpacity(0.9),
          onPressed: () {
            if (controller.teamAvatar != null) {
            controller.updateTeamAvatar(teamId: team.id!);
            } else {
              Constants.errorSnackBar(
                  title: 'Failed', message: 'Please select an image');
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

  Widget _buildButtons(TeamController controller, String teamId, TextEditingController nameController, TextEditingController descriptionController) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          final name = nameController.text.trim();
          final description = descriptionController.text.trim();
          controller.updateTeamData(teamId: teamId, name: name, description: description);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
