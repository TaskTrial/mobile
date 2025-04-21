import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/models/departments_model.dart';

import '../../controllers/department_controller.dart';
import '../../utils/constants.dart';
class EditDepartmentScreen extends StatelessWidget {
   EditDepartmentScreen({super.key, required this.department});
  final Department department;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: department.name);
    TextEditingController descriptionController = TextEditingController(text: department.description);
    final departmentController = Get.put(DepartmentController());
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text('Edit Department',
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
                SizedBox( height: 26),
                _buildInputField('Name', nameController,
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a department name';
                      }
                      return null;
                    }),
                const SizedBox(height: 16),
                _buildInputField("Description",descriptionController
                    ,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a department description';
                      }
                      return null;
                    },
                    maxLength: 200
                ),
                const SizedBox(height: 16),
                _buildButtons(departmentController, department.id!, nameController, descriptionController)
              ]
            ),
          )
        ),
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

   Widget _buildButtons(DepartmentController controller, String deptId, TextEditingController nameController, TextEditingController descriptionController) {
     return ElevatedButton(
       onPressed: () {
         if (formKey.currentState!.validate()) {
           final name = nameController.text.trim();
           final description = descriptionController.text.trim();
           controller.updateDepartmentData(deptId: deptId, name: name, description: description);
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
