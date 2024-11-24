import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../utils/validators/validation.dart';
import '../../../controller/emergency_contacts_controller/emergency_contacts_controller.dart';
// import '../../../../controller/disaster_controller.dart';

class EmergencyContactDepartmentNameField extends StatelessWidget {
  const EmergencyContactDepartmentNameField({
    super.key,
    required this.controller,
  });

  final EmergencyContactsController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.departmentName,
      validator: (value) => TValidator.validateEmptyText('Emergency Contact Department', value),
      expands: false,
      maxLines: 2,
      decoration: const InputDecoration(labelText: 'Emergency Contact Department', prefixIcon: Icon(Icons.emergency)),
    );
  }
}
