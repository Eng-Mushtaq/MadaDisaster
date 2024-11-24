import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/emergency_contacts_controller/emergency_contacts_controller.dart';
import 'emergency_contact_department_name.dart';
import 'emergency_contact_field.dart';

class AddEmergencyContactsForm extends StatelessWidget {
  const AddEmergencyContactsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmergencyContactsController());

    return Form(
      key: controller.addDisasterFormKey,
      child: Column(children: [
        // Dropdown Disaster Type
        DropdownButtonFormField(
          validator: (value) => TValidator.validateEmptyText('Emergency Department Service', value),
          decoration: const InputDecoration(labelText: 'Emergency Department Service', prefixIcon: Icon(Iconsax.sort_copy)),
          onChanged: (value) {
            EmergencyContactsController.instance.emergencyServiceCategory.value = value.toString();
          },
          items: ["Police", "Medical Services", "Fire Brigade", "Electricity Services", 'Army']
              .map(
                (option) => DropdownMenuItem(value: option, child: Text(option)),
              )
              .toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Emergency Contact Department Name
        EmergencyContactDepartmentNameField(
          controller: controller,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Emergency Contact Number
        EmergencyContactField(controller: controller),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Save button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => controller.saveEmergencyContact(),
            child: const Text('Add Contact'),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Cancel button
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(TTexts.cancel),
          ),
        ),
      ]),
    );
  }
}
