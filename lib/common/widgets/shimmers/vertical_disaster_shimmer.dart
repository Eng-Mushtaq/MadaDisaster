import 'package:flutter/material.dart';
import 'package:red_zone/common/widgets/layout/grid_layout.dart';
import 'package:red_zone/common/widgets/shimmers/shimmer.dart';
import 'package:red_zone/utils/constants/sizes.dart';

class TVerticalDisasterShimmer extends StatelessWidget {
  const TVerticalDisasterShimmer({super.key});

  final int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  TShimmerEffect(width: double.infinity, height: 370),
                  SizedBox(height: TSizes.spaceBtwItems),

                  // Text
                  TShimmerEffect(width: 160, height: 15),
                  SizedBox(height: TSizes.spaceBtwItems / 2),
                  TShimmerEffect(width: 110, height: 15)
                ],
              ),
            ));
  }
}
