import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_trial/models/organization_model.dart';
import 'package:task_trial/services/organization_services.dart';

class OrganizationController extends GetxController{
   OrganizationModel org = Get.arguments;
  final TextEditingController orgNameController = TextEditingController(
    text: Get.arguments.name,
  );
  final TextEditingController orgDescriptionController = TextEditingController(
    text: Get.arguments.description,
  );
  final TextEditingController orgPhoneController = TextEditingController(
    text: Get.arguments.contactPhone,
  );
  final TextEditingController orgEmailController = TextEditingController(
    text: Get.arguments.contactEmail,
  );
  final TextEditingController orgWebsiteController = TextEditingController(
    text: Get.arguments.website,
  );
  final TextEditingController orgAddressController = TextEditingController(
    text: Get.arguments.address,
  );
  final TextEditingController orgSizeRangeController = TextEditingController(
    text: Get.arguments.sizeRange,
  );
   final TextEditingController orgIndustryController = TextEditingController(
     text: Get.arguments.industry,
   );
   final TextEditingController orgLogoUrlController = TextEditingController(
     text: Get.arguments.logoUrl,
   );

    final formKey = GlobalKey<FormState>();
   XFile? logoImage;

   uploadLogoImage(XFile image) {
     logoImage = image;
     update();
   }

   deleteLogoImage(XFile image) {
     logoImage = null;
     update();
   }

   uploadLogoImageToServer(){
     OrganizationServices.updateLogoImage(File(logoImage!.path), org.id!);
   }
   updateOrganizationData(){
     OrganizationServices.updateOrganizationData(
         orgId: org.id!,
         nameController: orgNameController,
         descriptionController: orgDescriptionController,
         phoneNumberController: orgPhoneController,
         emailController: orgEmailController,
         addressController: orgAddressController,
         websiteController: orgWebsiteController,
         industryController: orgIndustryController,
         sizeRangeController: orgSizeRangeController,
         logoUrlController: orgLogoUrlController);
   }
   @override
  void onClose() {
    orgNameController.dispose();
    orgDescriptionController.dispose();
    orgPhoneController.dispose();
    orgEmailController.dispose();
    orgWebsiteController.dispose();
    orgAddressController.dispose();
    orgSizeRangeController.dispose();
    orgIndustryController.dispose();
    orgLogoUrlController.dispose();

    super.onClose();
  }
}