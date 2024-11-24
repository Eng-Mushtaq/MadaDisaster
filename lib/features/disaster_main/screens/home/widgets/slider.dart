import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_zone/features/disaster_main/controller/home_controller.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TSlider extends StatelessWidget {
  const TSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Column(children: [
      CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1,
          onPageChanged: (index, reason) => controller.updatePageIndicator(index),
        ),
        items: banners.map((url) => TRoundedImage(imageUrl: url)).toList(),
      ),
      const SizedBox(height: TSizes.spaceBtwItems),
      Center(
        child: Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < banners.length; i++)
                TCircularContainer(
                  width: 20,
                  height: 4,
                  margin: const EdgeInsets.only(right: 10),
                  backgroundColor: controller.carouselCurrentIndex.value == i ? TColors.primary : TColors.grey,
                ),
            ],
          ),
        ),
      ),
    ]);
  }
}
