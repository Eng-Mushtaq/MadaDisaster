import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:red_zone/common/widgets/images/rounded_container.dart';
import 'package:red_zone/common/widgets/products/ratings/rating_indicator.dart';
import 'package:red_zone/utils/constants/image_strings.dart';
import 'package:red_zone/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage(TImages.userProfileImage2)),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text('Avishka Dulanjana', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Review
        Row(
          children: [
            const TRatingBarIndicator(rating: 4),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('20 March 2024', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        const ReadMoreText(
          'How many people loss there properties? Can you have any phone number for contact them? I can help them.',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: 'show less',
          trimCollapsedText: 'show more',
          moreStyle: TextStyle(fontSize: 14, color: TColors.primary, fontWeight: FontWeight.bold),
          lessStyle: TextStyle(fontSize: 14, color: TColors.primary, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Post added user review
        TRoundedContainer(
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Mccoy Maxice', style: Theme.of(context).textTheme.titleMedium),
                    Text('22 March 2024', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                const ReadMoreText(
                  'Yes, I have the ministry number : 0787656789. Call them and ask how to contact them.',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: 'show less',
                  trimCollapsedText: 'show more',
                  moreStyle: TextStyle(fontSize: 14, color: TColors.primary, fontWeight: FontWeight.bold),
                  lessStyle: TextStyle(fontSize: 14, color: TColors.primary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
      ],
    );
  }
}
