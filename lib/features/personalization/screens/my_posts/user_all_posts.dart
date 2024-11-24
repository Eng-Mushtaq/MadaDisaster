import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_zone/common/widgets/layout/grid_layout.dart';
import 'package:red_zone/common/widgets/products/cards/card_vertical.dart';
import 'package:red_zone/common/widgets/shimmers/vertical_disaster_shimmer.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../controller/user_posts_controller/user_post_controller.dart';

class UserAllPostsListScreen extends StatelessWidget {
  const UserAllPostsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserAllDisasterFetchController());
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
      appBar: const TAppBar(
        title: Text('All Disaster Posts'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () {
            if (controller.isLoading.value) return const TVerticalDisasterShimmer();

            if (controller.disasterList.isEmpty) {
              return Center(
                child: Text(
                  'No Disasters Found',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }

            return TGridLayout(
              itemCount: controller.disasterList.length,
              itemBuilder: (_, index) {
                final disaster = controller.disasterList[index];
                return Dismissible(
                  key: Key(disaster.id), // Unique key for each dismissible item
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (_) async => await _showConfirmationDialog(context),
                  onDismissed: (direction) {
                    // Remove the item from the list and the database
                    controller.removeDisaster(disaster);
                  },
                  child: TVerticalCard(disaster: disaster),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this post?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed deletion
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User canceled deletion
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
