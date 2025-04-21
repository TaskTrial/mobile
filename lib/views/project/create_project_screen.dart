import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_trial/models/teams_model.dart';

import '../../controllers/project/create_project_controller.dart';
import '../../utils/constants.dart';

class CreateProjectScreen extends StatelessWidget {
  CreateProjectScreen({super.key, required this.teamsModel});
  final CreateProjectController controller = Get.put(CreateProjectController());
  final TeamsModel teamsModel ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Create Project',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: Constants.primaryFont,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInputField('Project Name', controller.nameController),
                const SizedBox(height: 16),
                _buildInputField(
                    'Description', controller.descriptionController,
                    maxLines: 4),
                const SizedBox(height: 16),
                _buildDatePicker('Start Date', isStart: true,context: context),
                const SizedBox(height: 16),
                _buildDatePicker('End Date', isStart: false,context: context),
                const SizedBox(height: 16),
                Text( 'Select team',
                  style: const TextStyle(
                    fontFamily: Constants.primaryFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  )),
                buildTeamDropdown(controller),
                const SizedBox(height: 16),
                Obx(()=>Text(
                  'Progress (${controller.progress.value}%)',
                  style: const TextStyle(
                    fontFamily: Constants.primaryFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ),
                Obx(() => Slider(
                      value: controller.progress.value.toDouble(),
                      min: 0,
                      max: 100,
                      divisions: 20,
                      label: '${controller.progress.value}%',
                      onChanged: (value) =>
                          controller.progress.value = value,
                      activeColor: Constants.primaryColor,
                    )),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: controller.submitProject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Create Project',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: Constants.primaryFont,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: Constants.primaryFont,
            )),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter $label' : null,
          decoration: InputDecoration(
            hintText: '$label is Empty!',
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontFamily: Constants.primaryFont,
            ),
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

  Widget _buildDatePicker(String label, {required BuildContext context ,required bool isStart}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: Constants.primaryFont,
            )),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => isStart?controller.pickStartDate(context):controller.pickEndDate(context),
          child: Obx(() {
            final date =
                isStart ? controller.startDate.value : controller.endDate.value;
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                date == null
                    ? 'Select $label'
                    : DateFormat('yyyy-MM-dd').format(date),
                style: const TextStyle(
                  fontFamily: Constants.primaryFont,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
  Widget buildTeamDropdown(CreateProjectController controller) {
    return Obx(() {
      return DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        value: controller.selectedTeamId.value.isEmpty ? null : controller.selectedTeamId.value,
        hint: const Text(
          'Select Team',
          style: TextStyle(
            fontFamily: Constants.primaryFont,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        style: const TextStyle(
          fontFamily: Constants.primaryFont,
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        items: teamsModel.data!.teams!.map((team) {
          return DropdownMenuItem<String>(
            value: team.id,
            child: Row(
              children: [
                team.avatar != null && team.avatar!.isNotEmpty
                    ? CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(team.avatar!),
                )
                    : const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.group, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 12),
                Text(
                  team.name!,
                  style: const TextStyle(
                    fontFamily: Constants.primaryFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            controller.selectedTeamId.value = value;
            print("Selected team ID: ${controller.selectedTeamId}");
          }
        },
        validator: (value) =>
        value == null || value.isEmpty ? 'Please select a team' : null,
      );

    });
  }

}
