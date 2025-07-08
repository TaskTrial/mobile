import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/task/edit_task_controller.dart';
import 'package:task_trial/models/task_model.dart';

import '../../controllers/ai_controller.dart';
import '../../controllers/project/project_controller.dart';
import '../../models/project_model.dart';
import '../../utils/constants.dart';
class EditTaskScreen extends StatelessWidget {
  final String teamId;
  final TaskModel task;
  final ProjectModel project;
  EditTaskScreen({super.key,  required this.teamId, required this.task, required this.project});
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
    final aiController = Get.put(AIController());
    final RxList<String> labels = (task.labels ?? []).obs;
    final TextEditingController labelController = TextEditingController();
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);
    final RxString priority = (task.priority ?? "LOW").obs;
    final RxString status = (task.status ?? "TODO").obs;
    final RxBool showTranslationOptions = false.obs;
    final Rx<TranslationDirection> translationDirection = TranslationDirection.englishToArabic.obs;

    final Rx<MemberModel> selectedAssignee = Rx<MemberModel>(
        (task.assignee != null
            ? (project.members ?? []).firstWhereOrNull(
                (member) => member.userId == task.assignee!.id)
            : null) ?? MemberModel(firstName: 'Not', lastName: 'Assigned')
    );




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
                    maxLines: 5, maxLength: 250),
                Obx(() => aiController.isLoading.value
                    ? const Center(child: CircularProgressIndicator(color: Constants.primaryColor))
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildFlexibleAIButton(
                          label: "Generate",
                          icon: Icons.auto_fix_high_rounded,
                          color: Colors.blueAccent,
                          onPressed: () => _handleAIAction(
                            aiController,
                            descriptionController,
                            "Generate a task description for me just 250 characters up to 500 characters: ",

                          ),
                        ),
                        _buildFlexibleAIButton(
                          label: "Translate",
                          icon: Icons.translate,
                          color: Colors.deepPurple,
                          onPressed:(){
                            showTranslationOptions.value = !showTranslationOptions.value;                          },
                        ),
                        _buildFlexibleAIButton(
                          label: "Summarize",
                          icon: Icons.summarize,
                          color: Colors.teal,
                          onPressed: () => _handleAIAction(
                            aiController,
                            descriptionController,
                            "Summarize this in 2-3 lines: ",

                          ),
                        ),
                        Obx(() => showTranslationOptions.value
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            const Text("Choose translation direction:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Constants.primaryFont)),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButton<TranslationDirection>(
                                isExpanded: true,
                                value: translationDirection.value,
                                underline: const SizedBox(),
                                onChanged: (val) {
                                  if (val != null) translationDirection.value = val;
                                },
                                items: [
                                  DropdownMenuItem(
                                    value: TranslationDirection.englishToArabic,
                                    child: const Text("English → Arabic"),
                                  ),
                                  DropdownMenuItem(
                                    value: TranslationDirection.arabicToEnglish,
                                    child: const Text("Arabic → English"),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.check,color: Colors.white,),
                                label: const Text("Translate Now",style: TextStyle(
                                    color:  Colors.white
                                ),),

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  final input = descriptionController.text.trim();
                                  if (input.isNotEmpty) {
                                    final prompt = translationDirection.value ==
                                        TranslationDirection.englishToArabic
                                        ? "Translate to Arabic, just the translation only, no explanation: $input"
                                        : "Translate to English, just the translation only, no explanation: $input";

                                    aiController.generateAIText(
                                      prompt: prompt,
                                      onSuccess: (result) {
                                        descriptionController.text = result;
                                        showTranslationOptions.value = false; // hide after done
                                      },
                                      onError: (err) {
                                        Get.snackbar("Error", err);
                                      },
                                    );
                                  } else {
                                    Get.snackbar("Input Required", "Please enter a description first.");
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                            : const SizedBox())

                      ],
                    ),
                  ],
                )),
                const SizedBox(height: 16),
                Obx(() => _buildDropdown("Priority", priority, [  "HIGH","MEDIUM","LOW"])),
                const SizedBox(height: 16),
                Obx(() => _buildDropdown("Status", status, ["TODO", "IN_PROGRESS", "REVIEW","DONE"])),
                const SizedBox(height: 16),
                Obx(() => _buildDatePicker("Due Date", dueDate, context)),
                const SizedBox(height: 16),
                Obx(() => _buildMemberDropdown("Assign To", selectedAssignee, project.members ?? [])),
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
                  selectedAssignee.value.userId ?? '',
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFlexibleAIButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 100),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: Constants.primaryFont,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  void _handleAIAction(
      AIController aiController,
      TextEditingController controller,
      String prefix,
      ) {
    final input = controller.text.trim();
    print("$prefix$input");
    if (input.isNotEmpty) {
      aiController.generateAIText(
        prompt: "$prefix$input",
        onSuccess: (result) => controller.text = result,
        onError: (err) => Get.snackbar("Error", err),
      );
    } else {
      Get.snackbar("Input Required", "Please enter a description first.");
    }
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

  Widget _buildMemberDropdown(String label, Rx<MemberModel> selected, List<MemberModel> members) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: Constants.primaryFont)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButton<MemberModel>(
            isExpanded: true,
            value: members.contains(selected.value) ? selected.value : null,
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(16),
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (newValue) {
              if (newValue != null) selected.value = newValue;
            },
            items: members.map((member) {
              return DropdownMenuItem<MemberModel>(
                value: member,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: member.profilePic != null
                          ? NetworkImage(member.profilePic!)
                          : null,
                      child: member.profilePic == null
                          ? const Icon(Icons.person, size: 16, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text('${member.firstName ?? ''} ${member.lastName ?? ''}',
                        style: const TextStyle(fontFamily: Constants.primaryFont)),
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
      String assignedTo
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
              "assignedTo": assignedTo,
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

enum TranslationDirection { arabicToEnglish, englishToArabic }
