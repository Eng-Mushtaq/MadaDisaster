import 'package:flutter/material.dart';
import 'package:red_zone/common/widgets/appbar/appbar.dart';
import 'package:red_zone/features/disaster_review/screen/widgets/rating_progress_indicator.dart';
import 'package:red_zone/features/disaster_review/screen/widgets/user_review_card.dart';
import 'package:red_zone/utils/constants/sizes.dart';

import '../../../common/widgets/products/ratings/rating_indicator.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text("Post Reviews & Ratings"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ratings and reviews are verified and from registered users."),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Overall Rating
              const TOverallDisasterRating(),
              const TRatingBarIndicator(rating: 3.5),
              Text("25", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              // User Reviews List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
