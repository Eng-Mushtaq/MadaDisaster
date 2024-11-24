import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:red_zone/features/disaster_main/models/disaster_model.dart';

import '../../../features/personalization/models/user_model.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class DisasterRepository extends GetxController {
  static DisasterRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Function to save new disaster record to firestore.
  Future<void> saveDisasterRecord(DisasterModel disasterModel) async {
    try {
      return await _db.collection('Disasters').doc(disasterModel.id).set(disasterModel.toJson());
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

  // Upload any Image to firebase storage
  Future<String> uploadDisasterImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
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

  // Update any field in specific users collection
  Future<void> updateSingleField(String documentId, Map<String, dynamic> json) async {
    try {
      await _db.collection('Disasters').doc(documentId).update(json);
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

  // Get disaster details
  Future<List<DisasterModel>> getDisasterDetails() async {
    try {
      final snapShot = await _db.collection('Disasters').limit(10).get();
      return snapShot.docs.map((e) => _mapToDisasterModel(e)).toList();
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

DisasterModel _mapToDisasterModel(DocumentSnapshot<Map<String, dynamic>> document) {
  if (document.data() == null) return DisasterModel.empty();
  final data = document.data()!;

  return DisasterModel(
    id: document.id,
    disasterLocation: PlaceLocation.fromJson(data['disasterLocation']),
    userId: data['userId'] ?? '',
    disasterType: data['disasterType'] ?? '',
    disasterProvince: data['disasterProvince'] ?? '',
    disasterDistrict: data['disasterDistrict'] ?? '',
    disasterDescription: data['disasterDescription'] ?? '',
    disasterImageUrls: List<String>.from(data['disasterImageUrls'] ?? []),
    createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    // Parse user data from map
    user: UserModel.fromJson(data['user'] ?? {}), // Assuming user data is stored under 'user' field
  );
}
