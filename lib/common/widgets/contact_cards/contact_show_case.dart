import 'package:flutter/material.dart';
import 'package:red_zone/features/emergency_contacts/model/contact_model.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../images/rounded_container.dart';
import 'emergecy_contact_card.dart';

class TContactShowcase extends StatelessWidget {
  const TContactShowcase({
    super.key,
    required this.contact,
  });

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      boarderColor: TColors.darkGrey,
      backgroundColor: Colors.black,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          TEmergencyContactCard(
            showBorder: false,
            contact: contact,
          ),
        ],
      ),
    );
  }
}
