import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_zone/utils/constants/loaders.dart';

import '../../../../admin_navigation_menu.dart';
import '../../../../data/repositories/contact/contact_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../emergency_contacts/model/contact_model.dart';

class EmergencyContactsController extends GetxController {
  static EmergencyContactsController get instance => Get.find();

  final disasterLoading = false.obs;
  Rx<ContactModel> disaster = ContactModel.empty().obs;

  // Form Fields
  final emergencyServiceCategory = RxString('');
  final departmentName = TextEditingController();
  final contactNo = TextEditingController();
  final contactRepository = Get.put(ContactRepository());
  var isLoading = false.obs;

  // List to hold selected image paths
  final RxList<String> disasterImages = RxList<String>();

  // Add Disaster Form Key
  GlobalKey<FormState> addDisasterFormKey = GlobalKey<FormState>();

  // Save Disaster Record to Firestore
  Future<void> saveEmergencyContact() async {
    // Start Loading
    TFullScreenLoader.openLoadingDialog(text: 'We are processing your information', animation: TImages.docerAnimation);

    // Check Internet Connection
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
    }

    // Form Validation
    if (!addDisasterFormKey.currentState!.validate()) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      return;
    }

    final userCredential = FirebaseAuth.instance.currentUser;

    try {
      final newContact = ContactModel(
        id: '${userCredential?.uid} - ${DateTime.now().millisecondsSinceEpoch}',
        emergencyServiceCategory: emergencyServiceCategory.value,
        departmentName: departmentName.text.trim(),
        contactNo: contactNo.text.trim(),
        createdAt: DateTime.now(),
      );

      print(newContact.toJson());

      await contactRepository.saveEmergencyContact(newContact);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(title: 'Successfully Added!!!', message: 'Your emergency contact has been submitted successfully!');

      // Clear the form fields
      emergencyServiceCategory.value = '';
      departmentName.clear();
      contactNo.clear();

      // Reset form key
      addDisasterFormKey.currentState!.reset();

      // Move to Previous Screen
      Get.offAll(() => const AdminNavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Data not saved', message: e.toString());
    }
  }
}
