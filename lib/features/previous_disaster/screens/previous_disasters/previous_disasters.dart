import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:red_zone/common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../common/widgets/shimmers/vertical_disaster_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../admin_panel/controller/previous_disaster/previous_disaster_fetch_controller.dart';
import '../../../admin_panel/screens/admin_disaster_home/widgets/previous_disaster_vertical_card.dart';
import 'Widgets/prediction_form.dart';
import 'Widgets/previous_disaster_tile.dart';

class PreviousDisasters extends StatelessWidget {
  const PreviousDisasters({super.key});
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
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TPreviousDisasterTile(),
                  Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),

                    // Prediction form
                    child: PredictionForm(),
                  ),
                ],
              ),
            ),
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
