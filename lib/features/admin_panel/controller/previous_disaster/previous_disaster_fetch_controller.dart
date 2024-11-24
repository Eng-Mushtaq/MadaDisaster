import 'package:get/get.dart';
import 'package:red_zone/utils/constants/loaders.dart';

import '../../../../data/repositories/admin_panel/admin_previous_disaster/admin_previous_disaster_repository.dart';
import '../../model/previous_disaster_model.dart';

class AdminPreviousDisasterFetchController extends GetxController {
  static AdminPreviousDisasterFetchController get instance => Get.find();

  final isLoading = false.obs;
  final disasterRepository = Get.put(AdminPreviousDisasterRepository());

  RxList<PreviousDisasterModel> disasterList = <PreviousDisasterModel>[].obs;

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

      // Show success message
      //TLoaders.successSnackBar(title: 'Success', message: 'Disaster data fetched successfully');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong! Please try again!(controller)');
    } finally {
      isLoading.value = false;
    }
  }
}
