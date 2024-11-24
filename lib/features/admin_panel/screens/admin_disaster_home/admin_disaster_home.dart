import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';
import 'package:red_zone/features/admin_panel/screens/admin_disaster_home/widgets/previous_disaster_vertical_card.dart';
import 'package:red_zone/utils/device/device_utility.dart';

import '../../../../common/widgets/admin_panel/admin_primary_header_container.dart';
import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../common/widgets/shimmers/vertical_disaster_shimmer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/previous_disaster/previous_disaster_fetch_controller.dart';
import '../admin_home/widgets/admin_home_appbar.dart';
import '../admin_previous_disaster/add_previous_disaster.dart';
import 'package:red_zone/features/disaster_main/screens/home/widgets/home_appbar.dart';

class AdminDisasterHomeScreen extends StatelessWidget {
  const AdminDisasterHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminPreviousDisasterFetchController());
    final scrollController = ScrollController();

    // Refresh function to be called when user scrolls to the top
    void refreshPage() {
      // Implement your refresh logic here
      controller.fetchDisasterList();
    }

    // Listen to scroll events and trigger refresh when user scrolls to the top
    scrollController.addListener(() {
      if (scrollController.offset <= scrollController.position.minScrollExtent) {
        refreshPage();
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Header
            TAdminPrimaryHeaderContainer(
              child: Column(
                children: [
                  // AppBar
                  const TAdminHomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: Container(
                      width: TDeviceUtils.getScreenWidth(context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                        border: Border.all(color: TColors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add Previous Disaster Reports',
                            style: TextStyle(
                              color: TColors.darkerGrey,
                              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Iconsax.add_circle, color: TColors.darkerGrey),
                            onPressed: () => Get.to(() => const AdminAddPreviousDisasterScreen()),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            // Slider
            Padding(
              padding: const EdgeInsets.all(1),
              child: Column(
                children: [
                  /// -- TODO: Disaster Cards --
                  Obx(
                    () {
                      if (controller.isLoading.value) return const TVerticalDisasterShimmer();

                      if (controller.disasterList.isEmpty) {
                        return Center(child: Text('No Previous Disasters Found', style: Theme.of(context).textTheme.bodyMedium));
                      }

                      //final reversedList = controller.disasterList.reversed.toList();
                      controller.disasterList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

                      return TGridLayout(
                        itemCount: controller.disasterList.length,
                        //itemBuilder: (_, index) => TVerticalCard(disaster: reversedList[index]),
                        itemBuilder: (_, index) => TAdminPreviousDisasterVerticalCard(disaster: controller.disasterList[index]),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
