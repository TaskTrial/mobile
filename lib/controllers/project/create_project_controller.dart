
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_trial/services/project_services.dart';
class CreateProjectController extends GetxController {
  final formKey = GlobalKey<FormState>();
  // Controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  // Observables
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().add(Duration(days: 1)).obs;
  final progress = 0.0.obs;
  final isSubmitting = false.obs;
  // Date formatter
  String formatDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  final selectedTeamId = ''.obs;

  // Date Pickers
  Future<void> pickStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      startDate.value = picked;
      if (picked.isAfter(endDate.value)) {
        endDate.value = picked.add(Duration(days: 1));
      }
    }
  }

  Future<void> pickEndDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: endDate.value,
      firstDate: startDate.value,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      endDate.value = picked;
    }
  }

  // Submit logic
  void submitProject() {
    if (!formKey.currentState!.validate()) return;
    isSubmitting.value = true;
    createProject();
    isSubmitting.value = false;
  }

  Future<void> createProject() async {
    ProjectServices.createProject(
      nameController: nameController,
      descriptionController: descriptionController,
      startDate: startDate,
      endDate: endDate,
      progress: progress,
      selectedTeamId: selectedTeamId,
    );
  }


  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
