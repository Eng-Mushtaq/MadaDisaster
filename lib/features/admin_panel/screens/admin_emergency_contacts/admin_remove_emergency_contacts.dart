import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_zone/common/widgets/appbar/appbar.dart';
import 'package:red_zone/utils/helpers/helper_functions.dart';

import '../../controller/all_emergency_contacts/all_emergency_contacts_controller.dart';

class AllEmergencyContactsScreen extends StatelessWidget {
  const AllEmergencyContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllEmergencyContactsController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('All Emergency Contacts'),
        // Add actions if needed
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return ListView.builder(
            itemCount: controller.contacts.length,
            itemBuilder: (context, index) {
              final contact = controller.contacts[index];
              return Column(
                children: [
                  Dismissible(
                    key: Key(contact.id),
                    background: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      final confirmed = await _showDeleteConfirmationDialog(context, controller, contact.id);
                      return confirmed ?? false; // Return false if user cancels
                    },
                    onDismissed: (direction) {
                      // Handle delete after confirmation
                      controller.deleteContact(contact.id);
                    },
                    child: ListTile(
                      title: Text(contact.departmentName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(contact.emergencyServiceCategory),
                          Text(contact.contactNo),
                          const SizedBox(height: 10),
                        ],
                      ),
                      trailing: const Icon(Icons.swipe_left), // Placeholder for the dismissible icon
                    ),
                  ),
                  Divider(color: darkMode ? Colors.white : Colors.black),
                ],
              );
            },
          );
        }
      }),
    );
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context, AllEmergencyContactsController controller, String contactId) async {
    final result = await showDialog<bool?>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this contact?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel delete
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                controller.deleteContact(contactId);
                Navigator.of(context).pop(true); // Confirm delete
              },
            ),
          ],
        );
      },
    );
    return result;
  }
}
