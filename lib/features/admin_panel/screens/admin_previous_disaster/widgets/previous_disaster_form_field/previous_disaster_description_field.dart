import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../controller/admin_previous_disaster_controller.dart';

class AdminPreviousDisasterDescriptionField extends StatelessWidget {
  const AdminPreviousDisasterDescriptionField({
    super.key,
    required this.controller,
  });

  final AdminPreviousDisasterController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.disasterDescription,
      validator: (value) => TValidator.validateEmptyText(TTexts.description, value),
      expands: false,
      maxLines: 3,
      decoration: const InputDecoration(labelText: TTexts.description, prefixIcon: Icon(Iconsax.user_edit)),
    );
  }
}
