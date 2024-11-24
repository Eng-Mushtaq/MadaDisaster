import 'package:flutter/material.dart';
import 'package:red_zone/common/widgets/shimmers/vertical_disaster_shimmer.dart';
import 'package:red_zone/features/emergency_contacts/controller/contact_controller.dart';
import 'package:red_zone/features/emergency_contacts/model/contact_model.dart';

import '../../../../common/widgets/contact_cards/contact_show_case.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';

class ContactsBrands extends StatelessWidget {
  const ContactsBrands({
    super.key,
    required this.contacts,
  });

  final ContactModel contacts;

  @override
  Widget build(BuildContext context) {
    final controller = ContactController.instance;
    return FutureBuilder(
        future: controller.getContactDetails(contacts.emergencyServiceCategory),
        builder: (context, snapshot) {
          const loader = Column(children: [
            TVerticalDisasterShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
          ]);

          final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

          if (widget != null) {
            return widget;
          }

          final emergencyContacts = snapshot.data!;

          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: emergencyContacts.length,
              itemBuilder: (_, index) {
                final contact = emergencyContacts[index];
                return FutureBuilder(
                    future: controller.getContactDetails(contact.emergencyServiceCategory),
                    builder: (context, snapshot) {
                      return TContactShowcase(contact: contact);
                    });
              });
        });
  }
}
