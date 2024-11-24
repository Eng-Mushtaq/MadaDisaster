import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DisasterPredictionRepository extends GetxController {
  static DisasterPredictionRepository get instance => Get.find();

  final _firestore = FirebaseFirestore.instance;

  Future<String?> getMonthUrl(String disasterType, String month) async {
    try {
      final docSnapshot = await _firestore.collection('DisasterPredictionDetails').doc(disasterType).get();

      // Check if the document exists and contains the month field
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data!.containsKey(month)) {
          return data[month];
        }
      }

      return null; // Return null if the document or month URL doesn't exist
    } catch (e) {
      print('Error fetching month URL: $e');
      throw 'Something went wrong while fetching month URL';
    }
  }
}
