import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../utils/validators/validation.dart';
import '../../../controller/emergency_contacts_controller/emergency_contacts_controller.dart';

class EmergencyContactField extends StatelessWidget {
  const EmergencyContactField({
    super.key,
    required this.controller,
  });

  final EmergencyContactsController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.contactNo,
      validator: (value) => TValidator.validateEmptyText('Emergency Contact', value),
      expands: false,
      maxLines: 2,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(labelText: 'Emergency Contact', prefixIcon: Icon(Icons.contacts)),
    );
  }
}
