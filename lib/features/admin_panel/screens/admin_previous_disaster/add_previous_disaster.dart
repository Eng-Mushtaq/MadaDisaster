import 'package:flutter/material.dart';

import 'package:red_zone/common/widgets/appbar/appbar.dart';
import 'package:red_zone/features/admin_panel/screens/admin_previous_disaster/widgets/admin_previous_disaster_form.dart';
import '../../../../utils/constants/sizes.dart';

class AdminAddPreviousDisasterScreen extends StatelessWidget {
  const AdminAddPreviousDisasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Previous Disasters Reports', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Previous Disaster Report', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Form
              AdminAddPreviousDisasterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
