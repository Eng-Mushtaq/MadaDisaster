import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../features/disaster_main/models/disaster_model.dart';
import '../../../../features/personalization/models/user_model.dart';
import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';

class AllDisasterPostRepository extends GetxController {
  static AllDisasterPostRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get disaster details
  Future<List<DisasterModel>> getDisasterDetails() async {
    try {
      final snapShot = await _db.collection('Disasters').limit(10).get();
      final disasterList = snapShot.docs.map((e) => _mapToDisasterModel(e)).toList();
      print('Fetched ${disasterList.length} disaster(s)');
      return disasterList;
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

  Future<void> deleteDisaster(String disasterId) async {
    try {
      await _db.collection('Disasters').doc(disasterId).delete();
      print('Disaster deleted: $disasterId');
    } catch (e) {
      print('Error deleting disaster: $e');
      throw 'Error deleting disaster. Please try again!';
    }
  }

  DisasterModel _mapToDisasterModel(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) {
      return DisasterModel.empty();
    }

    return DisasterModel(
      id: document.id,
      disasterLocation: PlaceLocation.fromJson(data['disasterLocation'] ?? {}),
      userId: data['userId'] ?? '',
      disasterType: data['disasterType'] ?? '',
      disasterProvince: data['disasterProvince'] ?? '',
      disasterDistrict: data['disasterDistrict'] ?? '',
      disasterDescription: data['disasterDescription'] ?? '',
      disasterImageUrls: List<String>.from(data['disasterImageUrls'] ?? []),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      // Parse user data from map
      user: UserModel.fromJson(data['user'] ?? {}),
    );
  }
}
