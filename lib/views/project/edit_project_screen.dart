import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/project/edit_project_controller.dart';
import '../../models/project_model.dart';
import '../../utils/constants.dart';

class EditProjectScreen extends StatelessWidget {
  final ProjectModel project;
  final String teamId;

  EditProjectScreen({super.key, required this.project, required this.teamId});

  final formKey = GlobalKey<FormState>();

  @override
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: project.name);
    final descriptionController = TextEditingController(text: project.description);
    final budgetController =
    TextEditingController(text: project.budget?.toString() ?? '0');
    final RxString priority = (project.priority ?? "LOW").obs;
    final RxString status = (project.status ?? "PLANNING").obs;
    final Rx<DateTime> startDate = DateTime.parse(project.startDate ?? DateTime.now().toIso8601String()).obs;
    final Rx<DateTime> endDate = DateTime.parse(project.endDate ?? DateTime.now().toIso8601String()).obs;
    final progress = project.progress!.toDouble().obs;
    final controller = Get.put(EditProjectController());
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Edit Project',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: Constants.primaryFont,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildInputField("Name", nameController),
                const SizedBox(height: 16),
                _buildInputField("Description", descriptionController,
                    maxLines: 3, maxLength: 200),
                const SizedBox(height: 16),
                Obx(() => _buildDropdown("Priority", priority, ["LOW", "MEDIUM", "HIGH","ARGENT"])),
                const SizedBox(height: 16),
                Obx(() => _buildDropdown("Status", status, ["PLANNING", "ACTIVE", "ON_HOLD","COMPLETED", "CANCELLED"])),
                const SizedBox(height: 16),
                Obx(() => _buildDatePicker("Start Date", startDate, context)),
                const SizedBox(height: 16),
                Obx(() => _buildDatePicker("End Date", endDate, context)),
                const SizedBox(height: 16),
                Obx(() => _buildProgressSlider(progress)),
                const SizedBox(height: 24),
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator(
                  color: Constants.primaryColor,
                )
                    : _buildSaveButton(
                  controller,
                  nameController,
                  descriptionController,
                  priority.value,
                  status.value,
                  startDate.value,
                  endDate.value,
                  double.tryParse(budgetController.text) ?? 0,
                  progress.value.toInt(),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildInputField(String label, TextEditingController controller,
      {int maxLines = 1, int? maxLength}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: Constants.primaryFont)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLength,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter $label';
            return null;
          },
          decoration: InputDecoration(
            hintText: '$label is empty!',
            hintStyle: const TextStyle(
                color: Colors.grey, fontSize: 14, fontFamily: Constants.primaryFont),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, RxString value, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: Constants.primaryFont)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: value.value,
            underline: const SizedBox(),
            onChanged: (newValue) {
              if (newValue != null) value.value = newValue;
            },
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item,
                    style: const TextStyle(
                      fontFamily: Constants.primaryFont,
                      fontWeight: FontWeight.bold,
                    )),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
  Widget _buildDatePicker(String label, Rx<DateTime> selectedDate, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: Constants.primaryFont)),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: selectedDate.value,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) selectedDate.value = picked;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${selectedDate.value.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontFamily: Constants.primaryFont),
                ),
                const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSlider(RxDouble progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Progress",
            style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: Constants.primaryFont)),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: progress.value,
                min: 0,
                max: 100,
                divisions: 100,
                label: '${progress.value.toInt()}%',
                onChanged: (value) => progress.value = value,
                activeColor:Constants.primaryColor,
                inactiveColor: Colors.grey,
              ),
            ),
            Text('${progress.value.toInt()}%'),
          ],
        ),
      ],
    );
  }

  Widget _buildSaveButton(
      EditProjectController controller,
      TextEditingController nameController,
      TextEditingController descriptionController,
      String priority,
      String status,
      DateTime startDate,
      DateTime endDate,
      double budget,
      int progress,
      ) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          controller.updateProjectData(
            teamId: teamId,
            projectId: project.id!,
            data: {
              "name": nameController.text.trim(),
              "description": descriptionController.text.trim(),
              "priority": priority,
              "status": status,
              "startDate": startDate.toIso8601String(),
              "endDate": endDate.toIso8601String(),
              "budget": budget,
              "progress": progress,
            },
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16

        )),
      ),
      child: const Text(
        "Save Changes",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: Constants.primaryFont,
        ),
      ),
    );
  }

}
