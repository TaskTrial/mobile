import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/controllers/create_department_controller.dart';
import 'package:task_trial/utils/constants.dart';

class CreateDepartmentScreen extends StatelessWidget {
  final String organizationId;
  final CreateDepartmentController controller = Get.put(CreateDepartmentController());
  CreateDepartmentScreen({super.key, required this.organizationId});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Department'),
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
                label: 'Department Name',
                hint: 'Enter department name',
                onChanged: (val) => controller.name.value = val,
                validator: (val) => val!.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 20),
              _customTextField(
                label: 'Description',
                hint: 'Enter department description',
                onChanged: (val) => controller.description.value = val,
                validator: (val) => val!.isEmpty ? 'Description is required' : null,
                maxLines: 3,
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
                      controller.createDepartment(organizationId);
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
