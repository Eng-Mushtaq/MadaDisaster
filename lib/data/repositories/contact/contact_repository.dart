import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:red_zone/features/emergency_contacts/model/contact_model.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ContactRepository extends GetxController {
  static ContactRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Function to fetch all contact details
  Future<List<ContactModel>> getContactDetails() async {
    try {
      final snapshot = await _db.collection('Contacts').get();
      final result = snapshot.docs.map((e) => ContactModel.fromSnapshot(e)).toList();
      return result;
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

  // Function to fetch specific contact details
  Future<List<ContactModel>> getContactsForCategory(String emergencyServiceCategory) async {
    try {
      QuerySnapshot contactCategoryQuery = await _db.collection('Contacts').where('emergencyServiceCategory', isEqualTo: emergencyServiceCategory).get();
      List<ContactModel> result = contactCategoryQuery.docs.map((doc) => ContactModel.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>)).toList();
      return result;
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

  // Function to save new disaster record to firestore.
  Future<void> saveEmergencyContact(ContactModel contactModel) async {
    try {
      return await _db.collection('Contacts').doc(contactModel.id).set(contactModel.toJson());
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
}
