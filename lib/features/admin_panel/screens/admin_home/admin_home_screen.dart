// import 'package:flutter/material.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:red_zone/features/disaster_main/controller/disasters/disaster_fetch_controller.dart';
// import 'package:red_zone/features/disaster_main/screens/home/widgets/home_appbar.dart';
// import 'package:red_zone/features/disaster_main/screens/home/widgets/slider.dart';
// import 'package:get/get.dart';
// import 'package:red_zone/features/disaster_main/screens/new_disaster/add_disaster.dart';
// import 'package:red_zone/utils/constants/image_strings.dart';
// import 'package:red_zone/utils/device/device_utility.dart';
//
// import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
// import '../../../../common/widgets/layout/grid_layout.dart';
// import '../../../../common/widgets/products/cards/card_vertical.dart';
// import '../../../../common/widgets/shimmers/vertical_disaster_shimmer.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/sizes.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(DisasterFetchController());
//     final scrollController = ScrollController();
//
//     // Refresh function to be called when user scrolls to the top
//     void refreshPage() {
//       // Implement your refresh logic here
//       controller.fetchDisasterList();
//     }
//
//     // Listen to scroll events and trigger refresh when user scrolls to the top
//     scrollController.addListener(() {
//       if (scrollController.offset <= scrollController.position.minScrollExtent) {
//         refreshPage();
//       }
//     });
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         controller: scrollController,
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             // Header
//             TPrimaryHeaderContainer(
//               child: Column(
//                 children: [
//                   // AppBar
//                   const THomeAppBar(),
//                   const SizedBox(height: TSizes.spaceBtwSections),
//
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
//                     child: Container(
//                       width: TDeviceUtils.getScreenWidth(context),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
//                         border: Border.all(color: TColors.grey),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Add New Disaster',
//                             style: TextStyle(
//                               color: TColors.darkerGrey,
//                               fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Iconsax.add_circle, color: TColors.darkerGrey),
//                             onPressed: () => Get.to(() => const NewDisasterScreen()),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: TSizes.spaceBtwSections),
//                 ],
//               ),
//             ),
//
//             // Slider
//             Padding(
//               padding: const EdgeInsets.all(1),
//               child: Column(
//                 children: [
//                   const Padding(
//                       padding: EdgeInsets.all(8),
//                       child: TSlider(
//                         banners: [TImages.bannersRedZone_01, TImages.bannersRedZone_02, TImages.bannersRedZone_03],
//                       )),
//                   const SizedBox(height: TSizes.spaceBtwSections),
//
//                   /// -- TODO: Disaster Cards --
//                   Obx(
//                     () {
//                       if (controller.isLoading.value) return const TVerticalDisasterShimmer();
//
//                       if (controller.disasterList.isEmpty) {
//                         return Center(child: Text('No Disasters Found', style: Theme.of(context).textTheme.bodyMedium));
//                       }
//
//                       //final reversedList = controller.disasterList.reversed.toList();
//                       controller.disasterList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//
//                       return TGridLayout(
//                         itemCount: controller.disasterList.length,
//                         //itemBuilder: (_, index) => TVerticalCard(disaster: reversedList[index]),
//                         itemBuilder: (_, index) => TVerticalCard(disaster: controller.disasterList[index]),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:red_zone/features/admin_panel/screens/admin_home/widgets/admin_home_appbar.dart';
import 'package:red_zone/features/disaster_main/controller/disasters/disaster_fetch_controller.dart';
import 'package:red_zone/features/disaster_main/screens/home/widgets/slider.dart';
import 'package:red_zone/features/disaster_main/screens/new_disaster/add_disaster.dart';
import 'package:red_zone/utils/constants/image_strings.dart';
import 'package:red_zone/utils/device/device_utility.dart';
import 'package:red_zone/common/widgets/layout/grid_layout.dart';
import 'package:red_zone/common/widgets/products/cards/card_vertical.dart';
import 'package:red_zone/common/widgets/shimmers/vertical_disaster_shimmer.dart';
import 'package:red_zone/utils/constants/colors.dart';
import 'package:red_zone/utils/constants/sizes.dart';
import '../../../../common/widgets/admin_panel/admin_primary_header_container.dart';
import '../../../disaster_main/models/disaster_model.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisasterFetchController());
    final scrollController = ScrollController();

    // Refresh function to be called when user scrolls to the top
    void refreshPage() async {
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
                            'Add New Disaster',
                            style: TextStyle(
                              color: TColors.darkerGrey,
                              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle, color: TColors.darkerGrey),
                            onPressed: () => Get.to(() => const NewDisasterScreen()),
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
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: TSlider(
                      banners: [TImages.bannersRedZone_01, TImages.bannersRedZone_02, TImages.bannersRedZone_03],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections / 8),

                  /// -- TODO: Disaster Cards --
                  Obx(
                    () {
                      if (controller.isLoading.value) return const TVerticalDisasterShimmer();

                      if (controller.disasterList.isEmpty) {
                        return Center(
                          child: Text(
                            'No Disasters Found',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }

                      // Create a copy of the disaster list for sorting
                      final List<DisasterModel> sortedDisasters = List.from(controller.disasterList);
                      // Sort the copy
                      sortedDisasters.sort((a, b) => b.createdAt.compareTo(a.createdAt));

                      return TGridLayout(
                        itemCount: sortedDisasters.length,
                        itemBuilder: (_, index) => TVerticalCard(disaster: sortedDisasters[index]),
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
