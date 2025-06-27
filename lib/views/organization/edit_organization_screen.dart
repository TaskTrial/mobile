import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_trial/controllers/profile/organization_controller.dart';
import 'package:task_trial/utils/constants.dart';
import 'package:task_trial/widgets/edit_photo_button.dart';

class EditOrganizationScreen extends StatelessWidget {
  const EditOrganizationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<OrganizationController>(
      init: OrganizationController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Constants.backgroundColor,
          body: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
            child: Column(
              children: [
                _appBar(width),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                        key: controller.formKey,
                        child: Column(children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          _profileImage(controller),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          _editProfileImage(controller),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          _buildInputField(
                              'Organization Name', controller.orgNameController,
                              validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          }),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          _buildInputField(
                              'Industry', controller.orgIndustryController,
                              validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Industry';
                            }
                            return null;
                          }),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          _buildInputField('Organization Description',
                              controller.orgDescriptionController,
                              validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Description';
                            }
                            return null;
                          }),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          _buildInputField(
                            'Contact Email', controller.orgEmailController,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your name';
                            //   }
                            //   if (!GetUtils.isEmail(value)) {
                            //     return 'Please enter a valid email';
                            //   }
                            //   return null;
                            // }
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          _buildInputField(
                            'Contact Phone', controller.orgPhoneController,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your name';
                            //   }
                            //
                            //   return null;
                            // }
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          _buildInputField(
                            'Address', controller.orgAddressController,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your name';
                            //   }
                            //   return null;
                            // }
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          _buildInputField(
                            'Website', controller.orgWebsiteController,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your name';
                            //   }
                            //   if (!GetUtils.isURL(value)) {
                            //     return 'Please enter a valid website';
                            //   }
                            //   return null;
                            // }
                          ),
                          // SizedBox(
                          //   height: height * 0.02,
                          // ),
                          // _editSizeRange(controller, 'Size Range',
                          //     controller.orgSizeRangeController,
                          //     validator: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return 'Choose a size range';
                          //       }
                          //       return null;
                          //     }),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          _buildButtons(controller),
                          SizedBox(
                            height: height * 0.02,
                          ),
                        ])),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _appBar(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: CircleAvatar(
              backgroundColor: Colors.white, child: Icon(Icons.arrow_back)),
        ),
        SizedBox(
          width: width * 0.1,
        ),
        Text(
          'Edit Organization',
          style: TextStyle(
              color: Constants.pageNameColor,
              fontFamily: Constants.primaryFont,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  _profileImage(OrganizationController controller) {
    return Center(
      child: controller.logoImage == null &&
              (controller.org.logoUrl == null ||
                  controller.org.logoUrl!.trim().isEmpty)
          ? CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFFFE3C5),
              child: Icon(Icons.account_balance_rounded,
                  size: 50, color: Colors.white),
            )
          : controller.logoImage == null &&
                  (controller.org.logoUrl != null &&
                      controller.org.logoUrl!.trim().isNotEmpty)
              ? CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(controller.org.logoUrl!),
                  ),
                )
              : CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage:
                        FileImage(File(controller.logoImage!.path)),
                  ),
                ),
    );
  }

  _editProfileImage(OrganizationController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EditPhotoButton(
          icon: Icons.upload,
          color: Constants.primaryColor,
          onPressed: () {
            ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
              if (value != null) {
                print(value.name);
                controller.uploadLogoImage(value);
              }
            });
          },
        ),
        EditPhotoButton(
          icon: Icons.delete,
          color: Colors.red,
          onPressed: () {
            if (controller.logoImage != null) {
              controller.deleteLogoImage(controller.logoImage!);
            }
          },
        ),
        EditPhotoButton(
          icon: Icons.check,
          color: Colors.green.withOpacity(0.9),
          onPressed: () {
            if (controller.logoImage != null) {
              controller.uploadLogoImageToServer();
            } else {
              Constants.errorSnackBar(
                  title: 'Failed', message: 'Please select an image');
            }
          },
        ),
      ],
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

  Widget _editSizeRange(OrganizationController orgController, String label,
      TextEditingController controller,
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
          readOnly: true,
          maxLength: maxLength,
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            suffixIcon: _myDropDownButton(orgController),
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

  _myDropDownButton(OrganizationController controller) {
    return DropdownMenu(
        width: 150,
        textStyle: TextStyle(
          fontSize: 16,
          color: Constants.pageNameColor,
          fontFamily: Constants.primaryFont,
          fontWeight: FontWeight.w600,
        ),
        controller: controller.orgSizeRangeController,
        hintText: 'Size Range',
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Constants.primaryColor,
              )),
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
        ]);
  }

  _buildButtons(OrganizationController controller) {
    return ElevatedButton(
      onPressed: () {
        if (controller.formKey.currentState!.validate()) {
          controller.updateOrganizationData();
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
