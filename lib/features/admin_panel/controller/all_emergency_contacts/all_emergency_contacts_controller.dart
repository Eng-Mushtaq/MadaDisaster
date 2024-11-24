import 'package:get/get.dart';
import 'package:red_zone/features/emergency_contacts/model/contact_model.dart';

import '../../../../data/repositories/admin_panel/all_emergency_contacts/all_emergency_contacts_repository.dart';

class AllEmergencyContactsController extends GetxController {
  static AllEmergencyContactsController get instance => Get.find();

  final AllEmergencyContactsRepository repository = Get.put(AllEmergencyContactsRepository());
  final contacts = <ContactModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    fetchContacts();
    super.onInit();
  }

  Future<void> fetchContacts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final List<ContactModel> fetchedContacts = await repository.getEmergencyContactDetails();
      contacts.assignAll(fetchedContacts);
    } catch (e) {
      errorMessage.value = 'Error fetching contacts: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteContact(String contactId) async {
    try {
      await repository.deleteEmergencyContacts(contactId);
      contacts.removeWhere((contact) => contact.id == contactId);
    } catch (e) {
      print('Error deleting contact: $e');
      // Handle error
    }
  }
}
