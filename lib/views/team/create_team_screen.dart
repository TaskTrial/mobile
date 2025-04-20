import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/create_department_controller.dart';
import 'package:task_trial/controllers/team_controller.dart';
import 'package:task_trial/utils/constants.dart';

class CreateTeamScreen extends StatelessWidget {
  final String organizationId;
  final TeamController controller = Get.put(TeamController());
  CreateTeamScreen({super.key, required this.organizationId});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Team'),
        backgroundColor: Constants.backgroundColor,
      ),
      backgroundColor: Constants.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _customTextField(
                label: 'Team Name',
                hint: 'Enter Team name',
                onChanged: (val) => controller.name.value = val,
                validator: (val) => val!.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 30),
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                    if (_formKey.currentState!.validate()) {
                      controller.createTeam(organizationId);
                    }
                  },
                  child: controller.isLoading.value
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'Create',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    required String label,
    required String hint,
    required Function(String) onChanged,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: [
        Text(label,
          style:  TextStyle(
            fontFamily: Constants.primaryFont,
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        TextFormField(
          onChanged: onChanged,
          validator: validator,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            labelStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Constants.primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade700),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Constants.primaryColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
