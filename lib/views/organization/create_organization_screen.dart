import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/widgets/my_text_field.dart';
import '../../controllers/auth/create_organization_controller.dart';

class CreateOrganizationScreen extends StatelessWidget {
  const CreateOrganizationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateOrganizationController());
    return Obx(() {
      if (!controller.initialize.value) {
        return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child:  Text('TaskTrial' , style: TextStyle(
                  fontFamily: Constants.primaryFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Constants.pageNameColor,
                  letterSpacing: 3,
                  wordSpacing: 5,
                  height: 3,
                  decoration: TextDecoration.none,
                  decorationColor: Constants.pageNameColor,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: 1.5,
                ))
            )
        );
      }
      return Scaffold(
        backgroundColor: Constants.backgroundColor,
        appBar: AppBar(
          backgroundColor: Constants.backgroundColor,
          elevation: 0,
          title: const Text("Create Organization", style: TextStyle(
              fontSize: 20,
              color: Constants.pageNameColor,
              fontFamily: Constants.primaryFont,
              fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                MyTextField(
                  radius: 20,
                  title: "Organization Name",
                  controller: controller.nameController,
                  hintText: "Ex : ABC Inc. ",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your organization name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                MyTextField(
                  radius: 20,
                  title: "Industry",
                  controller: controller.industryController,
                  hintText: "Ex: Software ",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your industry';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                MyTextField(
                  readOnly: true,
                  suffixIcon:_myDropDownButton(controller),
                  radius: 20,
                  title: "Size Range",
                  controller: controller.sizeRangeController,
                  hintText: "Size Range (e.g. 1-10)",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Select your Size Range';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                MyTextField(
                  radius: 20,
                  title: "Contact Email",
                  controller: controller.contactEmailController,
                  hintText: 'Enter your contact email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Contact Email';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Obx(() {
                  return controller.isLoading.value
                      ? const CircularProgressIndicator(
                    color: Constants.primaryColor,
                    strokeWidth: 2,
                    strokeCap: StrokeCap.round,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Constants.primaryColor,
                    ),
                  )
                      : ElevatedButton(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.createOrganization();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text("Create Organization", style: TextStyle(fontSize: 16)),
                  );
                }),
              ],
            ),
          ),
        ),
      );
    },);
  }
  _myDropDownButton(CreateOrganizationController controller) {
    return  DropdownMenu(
        width: 150,
        textStyle: TextStyle(
          fontSize: 16,
          color: Constants.pageNameColor,
          fontFamily: Constants.primaryFont,
          fontWeight: FontWeight.w600,
        ),
        controller: controller.sizeRangeController,
        hintText: 'Size Range',
        inputDecorationTheme:  InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: Constants.primaryColor,)
          ),
        ),
        dropdownMenuEntries: [
          DropdownMenuEntry(
            value: '1-10',
            label: '1-10',
          ),
          DropdownMenuEntry(
            value: '11-50',
            label: '11-50',
          ),
          DropdownMenuEntry(
            value: '51-200',
            label: '51-200',
          ),
          DropdownMenuEntry(
            value: '201-500',
            label: '201-500',
          ),
          DropdownMenuEntry(
            value: '501-1000',
            label: '501-1000',
          ),
          DropdownMenuEntry(
            value: '1000+',
            label: '1000+',
          )
        ]

    );
      }
}
