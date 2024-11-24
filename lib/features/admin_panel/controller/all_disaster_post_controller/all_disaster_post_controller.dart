import 'package:get/get.dart';
import 'package:red_zone/utils/constants/loaders.dart';

import '../../../../data/repositories/admin_panel/all_disaster_posts/all_disaster_posts_repository.dart';
import '../../../disaster_main/models/disaster_model.dart';

class AllDisasterFetchController extends GetxController {
  static AllDisasterFetchController get instance => Get.find();

  final isLoading = false.obs;
  final disasterRepository = Get.put(AllDisasterPostRepository());

  RxList<DisasterModel> disasterList = <DisasterModel>[].obs;

  @override
  void onInit() {
    fetchDisasterList();
    super.onInit();
  }

  void fetchDisasterList() async {
    try {
      // Start Loading
      isLoading.value = true;

      // fetch disaster list
      final disasters = await disasterRepository.getDisasterDetails();

      // assign fetched disaster
      disasterList.assignAll(disasters);

      print('Fetched ${disasterList.length} disaster(s)');

      // Show success message
      // TLoaders.successSnackBar(title: 'Success', message: 'Disaster data fetched successfully');
    } catch (e) {
      print('Error fetching disaster list: $e');
      TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong! Please try again!(controller)');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeDisaster(DisasterModel disaster) async {
    try {
      // Remove disaster from Firestore
      await disasterRepository.deleteDisaster(disaster.id);

      // Remove disaster from the list
      disasterList.remove(disaster);
    } catch (e) {
      print('Error removing disaster: $e');
      // Handle error as needed
    }
  }
}
