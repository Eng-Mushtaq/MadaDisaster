import 'package:flutter/material.dart';

import 'package:red_zone/common/widgets/appbar/appbar.dart';
import 'package:red_zone/features/disaster_main/screens/new_disaster/widgets/add_disaster_form.dart';
import 'package:red_zone/utils/constants/text_strings.dart';
import '../../../../utils/constants/sizes.dart';

class NewDisasterScreen extends StatelessWidget {
  const NewDisasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Add Disaster', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TTexts.addDisasterTitle, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Form
              AddDisasterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
