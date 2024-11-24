import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:red_zone/features/disaster_main/models/disaster_model.dart';

import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../controller/disasters/images_controller.dart';
import 'curved_edges_widget.dart';

class TDisasterImageSlider extends StatelessWidget {
  const TDisasterImageSlider({
    super.key,
    required this.disaster,
  });

  final DisasterModel disaster;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final controller = Get.put(ImagesController());
    final images = controller.getAllDisasterImages(disaster);

    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(children: [
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Center(
                child: Obx(
                  () {
                    final image = controller.selectedImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        height: 400,
                        progressIndicatorBuilder: (_, __, downloadProgress) => CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: TColors.primary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Disaster Image Slider
          Positioned(
            right: 0,
            bottom: 30,
            left: TSizes.defaultSpace,
            child: SizedBox(
              height: 60,
              child: ListView.separated(
                itemCount: images.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
                itemBuilder: (_, index) => Obx(
                  () {
                    final imageSelected = controller.selectedImage.value == images[index];
                    return TRoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      padding: const EdgeInsets.all(1),
                      imageUrl: images[index],
                      fit: BoxFit.cover,
                      applyImageRadius: true,
                      onPressed: () => controller.selectedImage.value = images[index],
                      backgroundColor: dark ? TColors.darkerGrey : TColors.light,
                      border: Border.all(color: imageSelected ? TColors.primary : Colors.transparent),
                    );
                  },
                ),
              ),
            ),
          ),

          // Appbar
          const TAppBar(
            showBackArrow: true,
            actions: [
              Icon(
                Iconsax.heart,
                color: TColors.white,
              )
            ],
          )
        ]),
      ),
    );
  }
}
