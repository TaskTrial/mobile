import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ai_controller.dart';
import '../../controllers/project/project_controller.dart';
import '../../models/project_model.dart';

import '../../services/gemini_ai_service.dart';
import '../../utils/constants.dart';

class EditProjectScreen extends StatelessWidget {
  final ProjectModel project;
  final String teamId;

  EditProjectScreen({super.key, required this.project, required this.teamId});

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final aiController = Get.put(AIController());

    final nameController = TextEditingController(text: project.name);
    final descriptionController = TextEditingController(text: project.description);
    final budgetController = TextEditingController(text: project.budget?.toString() ?? '0');
    final RxString priority = (project.priority ?? "LOW").obs;
    final RxString status = (project.status ?? "PLANNING").obs;
    final Rx<DateTime> startDate = DateTime.parse(project.startDate ?? DateTime.now().toIso8601String()).obs;
    final Rx<DateTime> endDate = DateTime.parse(project.endDate ?? DateTime.now().toIso8601String()).obs;
    final progress = project.progress!.toDouble().obs;
    final controller = Get.put(ProjectController());
    final RxBool showTranslationOptions = false.obs;
    final Rx<TranslationDirection> translationDirection = TranslationDirection.englishToArabic.obs;


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
                _buildInputField("Description", descriptionController, maxLines: 10, maxLength: 1000),
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
                            "Generate: ",

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
                Obx(() => _buildDropdown("Priority", priority, ["LOW", "MEDIUM", "HIGH", "ARGENT"])),
                const SizedBox(height: 16),
                Obx(() => _buildDropdown("Status", status, ["PLANNING", "ACTIVE", "ON_HOLD", "COMPLETED", "CANCELED"])),
                const SizedBox(height: 16),
                Obx(() => _buildDatePicker("Start Date", startDate, context)),
                const SizedBox(height: 16),
                Obx(() => _buildDatePicker("End Date", endDate, context)),
                const SizedBox(height: 16),
                Obx(() => _buildProgressSlider(progress)),
                const SizedBox(height: 24),
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator(color: Constants.primaryColor)
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
      ProjectController controller,
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
enum TranslationDirection { arabicToEnglish, englishToArabic }
