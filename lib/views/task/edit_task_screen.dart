import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/task/edit_task_controller.dart';
import 'package:task_trial/models/task_model.dart';

import '../../controllers/project/project_controller.dart';
import '../../models/project_model.dart';
import '../../utils/constants.dart';
class EditTaskScreen extends StatelessWidget {
  final String teamId;
  final TaskModel task;
  EditTaskScreen({super.key,  required this.teamId, required this.task});
  final formKey = GlobalKey<FormState>();
  final Map<String,Widget> icons={
    "LOW":const Icon(Icons.arrow_downward,color: Colors.greenAccent,),
    "MEDIUM":const Icon(Icons.arrow_forward,color: Colors.yellow),
    "HIGH":const Icon(Icons.arrow_upward, color: Colors.redAccent),
    "DONE":const Icon(Icons.check , color: Colors.greenAccent),
    "IN_PROGRESS":const Icon(Icons.hourglass_empty, color: Colors.blueAccent),
    "REVIEW":const Icon(Icons.lock_clock, color: Colors.blueGrey),
    "TODO":const Icon(Icons.priority_high_sharp, color: Colors.redAccent),
  };
  @override
  @override
  Widget build(BuildContext context) {
    final RxList<String> labels = (task.labels ?? []).obs;
    final TextEditingController labelController = TextEditingController();
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);
    final RxString priority = (task.priority ?? "LOW").obs;
    final RxString status = (task.status ?? "TODO").obs;
    final Rx<DateTime> dueDate = DateTime.parse(task.dueDate ?? DateTime.now().toIso8601String()).obs;
    final controller = Get.put(EditTaskController());
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Edit Task',
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
                _buildInputField("Title", titleController),
                const SizedBox(height: 16),
                _buildInputField("Description", descriptionController,
                    maxLines: 3, maxLength: 200),
                const SizedBox(height: 16),
                Obx(() => _buildDropdown("Priority", priority, [  "HIGH","MEDIUM","LOW"])),
                const SizedBox(height: 16),
                Obx(() => _buildDropdown("Status", status, ["TODO", "IN_PROGRESS", "REVIEW","DONE"])),
                const SizedBox(height: 16),
                Obx(() => _buildDatePicker("Due Date", dueDate, context)),
                const SizedBox(height: 16),
                _buildLabelsField(labels, labelController),
                const SizedBox(height: 24),
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator(
                  color: Constants.primaryColor,
                )
                    : _buildSaveButton(
                  controller,
                  titleController,
                  descriptionController,
                  priority.value,
                  status.value,
                  dueDate.value,
                  labels.toList(),
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
            dropdownColor: Colors.white,
            style:  TextStyle(
                fontFamily: Constants.primaryFont,
                fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(16),
            isExpanded: true,
            value: value.value,
            underline: const SizedBox(),
            onChanged: (newValue) {
              print(newValue);
              if (newValue != null) value.value = newValue;
            },
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Row(
                  children: [
                    icons[item]!,
                    SizedBox(width: 8),
                    Text(item,
                        style: const TextStyle(
                          fontFamily: Constants.primaryFont,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
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

  Widget _buildSaveButton(
      EditTaskController controller,
      TextEditingController titleController,
      TextEditingController descriptionController,
      String priority,
      String status,
      DateTime dueDate,
      List<String> labels,
      ) {
    return ElevatedButton(
      onPressed: () {
        print(status);
        if (formKey.currentState!.validate()) {
          controller.updateTaskData(
            taskId: task.id!,
            teamId:teamId,
            projectId: task.project!.id!,
            data: {
              "title": titleController.text.trim(),
              "description": descriptionController.text.trim(),
              "priority": priority,
                "status": status,
              "dueDate": dueDate.toIso8601String(),
              "labels": labels,
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
  Widget _buildLabelsField(RxList<String> labels, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Labels", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: Constants.primaryFont)),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Enter label",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                final text = controller.text.trim();
                if (text.isNotEmpty && !labels.contains(text)) {
                  labels.add(text);
                  controller.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text("Add",style: TextStyle(fontFamily: Constants.primaryFont,fontWeight: FontWeight.bold,color: Colors.white),),
            )
          ],
        ),
        const SizedBox(height: 8),
        Obx(() => Wrap(
          spacing: 8,
          children: labels.map((label) {
            return Chip(
              side: BorderSide.none,
              backgroundColor:  Constants.primaryColor.withOpacity(0.8),
              deleteIcon: const Icon(Icons.close,color: Colors.white,),
              label: Text(label,style: const TextStyle(fontFamily: Constants.primaryFont,fontWeight: FontWeight.bold,color: Colors.white),),
              onDeleted: () => labels.remove(label),
            );
          }).toList(),
        )),
      ],
    );
  }


}
