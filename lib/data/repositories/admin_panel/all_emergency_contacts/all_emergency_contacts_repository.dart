import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../features/emergency_contacts/model/contact_model.dart';
import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';

class AllEmergencyContactsRepository extends GetxController {
  static AllEmergencyContactsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get disaster details
  Future<List<ContactModel>> getEmergencyContactDetails() async {
    try {
      final snapShot = await _db.collection('Contacts').limit(10).get();
      final contactList = snapShot.docs.map((e) => _mapToContactModel(e)).toList();
      print('Fetched ${contactList.length} contact(s)');
      return contactList;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong! Please try again!';
    }
  }

  Future<void> deleteEmergencyContacts(String contactId) async {
    try {
      await _db.collection('Contacts').doc(contactId).delete();
      print('Contact deleted: $contactId');
    } catch (e) {
      print('Error deleting contact: $e');
      throw 'Error deleting contact. Please try again!';
    }
  }

  ContactModel _mapToContactModel(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) {
      return ContactModel.empty();
    }

    return ContactModel(
      id: document.id,
      emergencyServiceCategory: data['emergencyServiceCategory'],
      departmentName: data['departmentName'],
      contactNo: data['contactNo'],
    );
  }
}
