import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/repositories/disaster_prediction/disaster_prediction_repository.dart';

class PredictionController extends GetxController {
  static PredictionController get instance => Get.find();

  final disasterType = RxString('');
  final month = RxString('');

  void setDisasterType(String value) {
    disasterType.value = value;
  }

  void setMonth(String value) {
    month.value = value;
  }

  Future<void> launchPrediction() async {
    final String disaster = disasterType.value;
    final String selectedMonth = month.value;

    try {
      // Fetch HTML file URL from Fire store based on the selected disaster type and month
      final String? url = await DisasterPredictionRepository.instance.getMonthUrl(disaster, selectedMonth);

      // If URL is available, launch it
      if (url != null && url.isNotEmpty) {
        await _launchUrl(url);
      } else {
        throw 'No HTML file URL found for the selected disaster and month';
      }
    } catch (e) {
      print('Error launching prediction: $e');
      rethrow; // Rethrow the error to be caught by the caller
    }
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri encodedUrl = Uri.parse(url);
      if (!await launchUrl(encodedUrl)) {
        throw 'Could not launch $encodedUrl';
      }
    } catch (e) {
      print('Error launching URL: $e');
      rethrow;
    }
  }
}
