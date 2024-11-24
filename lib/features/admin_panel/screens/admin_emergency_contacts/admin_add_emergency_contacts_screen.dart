import 'package:flutter/material.dart';
import 'package:red_zone/common/widgets/appbar/appbar.dart';
import 'package:red_zone/features/admin_panel/screens/admin_emergency_contacts/widgets/add_emergency_contacts_form.dart';

import '../../../../utils/constants/sizes.dart';

class AdminAddEmergencyContactsScreen extends StatelessWidget {
  const AdminAddEmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Add Emergency Contacts', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Emergency Contacts', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Form
              const AddEmergencyContactsForm(),
            ],
          ),
        ),
      ),
    );
  }
}
