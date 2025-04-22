import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_trial/controllers/create_task_controller.dart';
import 'package:task_trial/models/project_model.dart';
import 'package:task_trial/models/teams_model.dart';

import '../../controllers/project/create_project_controller.dart';
import '../../utils/constants.dart';

class CreateTaskScreen extends StatelessWidget {
  CreateTaskScreen({super.key, required this.projects, });
  final CreateTaskController controller = Get.put(CreateTaskController());
  final List <ProjectModel> projects ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Create Task',
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
                _buildInputField('Task Title', controller.titleController),
                const SizedBox(height: 16),
                _buildInputField(
                    'Task Description', controller.descriptionController,
                    maxLines: 4),
                const SizedBox(height: 16),
                _buildDatePicker('Duo Date', isStart: true,context: context),
                const SizedBox(height: 16),
                Text( 'Select project',
                    style: const TextStyle(
                      fontFamily: Constants.primaryFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    )),
                buildProjectDropdown(controller),
                const SizedBox(height: 16),
                Text( 'Select Priority',
                    style: const TextStyle(
                      fontFamily: Constants.primaryFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    )),
                buildPriorityDropdown(controller),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: controller.submitTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Create Task',
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
          onTap: () => controller.pickDueDate(context),
          child: Obx(() {
            final date = controller.dueDate.value;
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
  Widget buildProjectDropdown(CreateTaskController controller) {
    return Obx(() {
      return DropdownButtonFormField<ProjectModel>(
        dropdownColor: Colors.white,
        value: controller.selectedProject.value,
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
        items: projects.map((project) {
          return DropdownMenuItem<ProjectModel>(
            value: project,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.work, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 12),
                Text(
                  project.name!,
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
        onChanged: (project) {
          if (project != null) {
            controller.selectedProject.value = project;
            controller.selectedProjectId.value = project.id!;
            controller.selectedTeamId.value = project.team!.id!;
            print("Selected team ID: ${project.team!.id!}");
            print("Selected project ID: ${project.id}");
          }
        },
        validator: (value) =>
        value == null ? 'Please select a team' : null,
      );
    });
  }
  Widget buildPriorityDropdown(CreateTaskController controller) {
    final List<String> priorities = ['HIGH', 'MEDIUM', 'LOW'];

    return Obx(() {
      return DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        value: controller.selectedPriority.value.isEmpty
            ? null
            : controller.selectedPriority.value,
        hint: const Text(
          'Select Priority',
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

        items: priorities.map((priority) {
          return DropdownMenuItem<String>(
            value: priority,
            child: Row(
              children: [
                Icon(
                  Icons.flag,
                  color: priority == 'HIGH'
                      ? Colors.red
                      : priority == 'MEDIUM'
                      ? Colors.orange
                      : Colors.green,
                  size: 18,
                ),
                const SizedBox(width: 12),
                Text(
                  priority,
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
            controller.selectedPriority.value = value;
            print("Selected priority: ${controller.selectedPriority.value}");
          }
        },
        validator: (value) =>
        value == null || value.isEmpty ? 'Please select a priority' : null,
      );
    });
  }


}
