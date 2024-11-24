import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/prediction_controller.dart';

class PredictionForm extends StatelessWidget {
  const PredictionForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final predictionController = Get.put(PredictionController());

    return Form(
      child: Column(
        children: <Widget>[
          Text(' Upcoming Disaster Risk Predictions Powered by AI ', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems / 4),
          const Divider(color: TColors.grey),
          const SizedBox(height: TSizes.spaceBtwItems),
          DropdownButtonFormField(
            validator: (value) => TValidator.validateEmptyText(TTexts.disasterType, value),
            decoration: const InputDecoration(
                labelText: TTexts.disasterType, labelStyle: TextStyle(color: TColors.white, fontWeight: FontWeight.bold, fontSize: 16), prefixIcon: Icon(Iconsax.sort_copy, color: TColors.white)),
            onChanged: (value) {
              predictionController.setDisasterType(value!); // Set the selected disaster type
            },
            items: ["Flood", "Drought", "Earthquake", "Tsunami", "Storm"]
                .map(
                  (option) => DropdownMenuItem(value: option, child: Text(option)),
                )
                .toList(),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          DropdownButtonFormField(
            validator: (value) => TValidator.validateEmptyText(TTexts.month, value),
            decoration: const InputDecoration(
                labelText: TTexts.month, labelStyle: TextStyle(color: TColors.white, fontWeight: FontWeight.bold, fontSize: 16), prefixIcon: Icon(Iconsax.sort_copy, color: TColors.white)),
            onChanged: (value) {
              predictionController.setMonth(value!); // Set the selected month
            },
            items: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
                .map(
                  (option) => DropdownMenuItem(value: option, child: Text(option)),
                )
                .toList(),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.white,
              ),
              onPressed: () {
                predictionController.launchPrediction(); // Call the launchPrediction method from PredictionController
              },
              child: const Text(TTexts.prediction, style: TextStyle(color: TColors.black)),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Center(
            child: Text(
              'Get instant district-wise disaster risk predictions powered by AI technology. Stay informed and prepared with just one click.',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: TColors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
        ],
      ),
    );
  }
}
