import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_zone/features/disaster_main/models/disaster_model.dart';
import 'package:red_zone/utils/constants/sizes.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  // Variables
  RxString selectedImage = ''.obs;

  // Get All Images
  List<String> getAllDisasterImages(DisasterModel disaster) {
    // Use set to add unique images only
    Set<String> images = {};

    // Load thumbnail image
    images.add(disaster.disasterImageUrls?.isNotEmpty == true ? disaster.disasterImageUrls!.first : '');

    // Assign Thumbnail as Selected Image
    selectedImage.value = disaster.disasterImageUrls!.first;

    // Get all images from the disaster model if not null
    if (disaster.disasterImageUrls != null) {
      images.addAll(disaster.disasterImageUrls!);
    }

    return images.toList();
  }

  // Show Image Popup
  void showEnlargedImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace * 2, horizontal: TSizes.defaultSpace),
                    child: CachedNetworkImage(imageUrl: image),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 8),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ));
  }
}
