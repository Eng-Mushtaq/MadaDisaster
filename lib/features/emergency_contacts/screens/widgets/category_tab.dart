import 'package:flutter/material.dart';
import 'package:red_zone/features/emergency_contacts/model/contact_model.dart';

import '../../../../utils/constants/sizes.dart';
import 'contacts_brands.dart';

class TCategoryTab extends StatelessWidget {
  final List<ContactModel> contacts;

  const TCategoryTab({Key? key, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Display your ContactsBrands widget here
              ContactsBrands(contacts: contacts.first), // Assuming contacts list contains the same category
            ],
          ),
        ),
      ],
    );
  }
}
