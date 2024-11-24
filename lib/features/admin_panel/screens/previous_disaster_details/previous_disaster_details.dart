import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:red_zone/common/widgets/custom_shapes/containers/section_heading.dart';
import 'package:red_zone/features/admin_panel/screens/previous_disaster_details/widgets/previous_disaster_detail_image_slider.dart';
import 'package:red_zone/features/admin_panel/screens/previous_disaster_details/widgets/previous_disaster_details_contents.dart';
import 'package:red_zone/features/admin_panel/screens/previous_disaster_details/widgets/previous_disaster_map.dart';
import 'package:red_zone/features/disaster_main/screens/disaster_details/widgets/disaster_details_widgets/rating_share_widget.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../disaster_review/screen/product_reviews.dart';
import '../../model/previous_disaster_model.dart';

class AdminPreviousDisasterDetails extends StatelessWidget {
  const AdminPreviousDisasterDetails({super.key, required this.disaster});

  final PreviousDisasterModel disaster;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Disaster Image Slider

            TPreviousDisasterImageSlider(disaster: disaster),

            // Disaster Details
            const Padding(
              padding: EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  // Disaster Ratings and Share
                  TRatingAndShare(),
                ],
              ),
            ),

            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Disaster Details
            TPreviousDisasterDetails(disaster: disaster),
            const SizedBox(height: TSizes.spaceBtwItems),

            // fetch Disaster Map Container
            TPreviousDisasterMap(
              disaster: disaster,
              isLoading: false,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Reviews
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const TSectionHeading(title: '  Reviews(25)', showActionButton: false),
              IconButton(onPressed: () => Get.to(() => const ProductReviewsScreen()), icon: const Icon(Iconsax.arrow_right_3_copy, size: 18))
            ]),
            const SizedBox(height: TSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
