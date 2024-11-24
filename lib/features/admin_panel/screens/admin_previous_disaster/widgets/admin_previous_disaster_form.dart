import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';
import 'package:red_zone/features/admin_panel/model/previous_disaster_model.dart';
import 'package:red_zone/features/admin_panel/screens/admin_previous_disaster/widgets/previous_disaster_form_field/previous_disaster_description_field.dart';
import 'package:red_zone/features/admin_panel/screens/admin_previous_disaster/widgets/previous_disaster_form_field/previous_disaster_image_pick.dart';
import 'package:red_zone/features/admin_panel/screens/admin_previous_disaster/widgets/previous_disaster_form_field/previous_disaster_map_selection.dart';
import 'package:red_zone/features/admin_panel/screens/admin_previous_disaster/widgets/previous_disaster_form_field/previous_disaster_map_selection_buttons.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/admin_previous_disaster_controller.dart';

class AdminAddPreviousDisasterForm extends StatelessWidget {
  AdminAddPreviousDisasterForm({super.key});

  final pickedLocation = Rx<PlaceLocation?>(null);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminPreviousDisasterController());

    return Form(
      key: controller.addDisasterFormKey,
      child: Column(children: [
        // Dropdown Disaster Type
        DropdownButtonFormField(
          validator: (value) => TValidator.validateEmptyText(TTexts.disasterType, value),
          decoration: const InputDecoration(labelText: TTexts.disasterType, prefixIcon: Icon(Iconsax.sort_copy)),
          onChanged: (value) {
            AdminPreviousDisasterController.instance.disasterType.value = value.toString();
          },
          items: ["Flood", "Land Slide", "Earthquake", "Tsunami", "Storm"]
              .map(
                (option) => DropdownMenuItem(value: option, child: Text(option)),
              )
              .toList(),
        ),

        // Dropdown Province
        Padding(
          padding: const EdgeInsets.only(top: TSizes.spaceBtwInputFields),
          child: DropdownButtonFormField(
            validator: (value) => TValidator.validateEmptyText(TTexts.disasterProvince, value),
            decoration: const InputDecoration(labelText: TTexts.disasterProvince, prefixIcon: Icon(Iconsax.sort_copy)),
            onChanged: (value) {
              AdminPreviousDisasterController.instance.disasterProvince.value = value.toString();
            },
            items: [
              "Central Province",
              "Eastern Province",
              "North Central Province",
              "Northern Province",
              "North Western Province",
              "Sabaragamuwa Province",
              "Southern Province",
              "Uva Province",
              "Western Province"
            ]
                .map(
                  (option) => DropdownMenuItem(value: option, child: Text(option)),
                )
                .toList(),
          ),
        ),

        // Dropdown District
        Padding(
          padding: const EdgeInsets.only(top: TSizes.spaceBtwInputFields),
          child: DropdownButtonFormField(
            validator: (value) => TValidator.validateEmptyText(TTexts.disasterDistrict, value),
            decoration: const InputDecoration(labelText: TTexts.disasterDistrict, prefixIcon: Icon(Iconsax.sort_copy)),
            onChanged: (value) {
              AdminPreviousDisasterController.instance.disasterDistrict.value = value.toString();
            },
            items: [
              "Ampara",
              "Anuradhapura",
              "Badulla",
              "Batticaloa",
              "Colombo",
              "Galle",
              "Gampaha",
              "Hambantota",
              "Jaffna",
              "Kalutara",
              "Kandy",
              "Kegalle",
              "Kilinochchi",
              "Kurunegala",
              "Mannar",
              "Matale",
              "Matara",
              "Monaragala",
              "Mullaitivu",
              "Nuwara Eliya",
              "Polonnaruwa",
              "Puttalam",
              "Ratnapura",
              "Trincomalee",
              "Vavuniya"
            ]
                .map(
                  (option) => DropdownMenuItem(value: option, child: Text(option)),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Description
        AdminPreviousDisasterDescriptionField(controller: controller),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Disaster Images',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Image on disaster
        AdminPreviousDisasterImagePick(controller: controller),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Disaster Location',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Map Selection
        const AdminPreviousDisasterMapSelection(),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Map selection buttons
        AdminPreviousDisasterMapSelectionButtons(controller: controller),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Save button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => controller.saveDisasterRecord(),
            child: const Text(TTexts.addDisaster),
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
