import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../controller/admin_previous_disaster_controller.dart';

class AdminPreviousDisasterImagePick extends StatelessWidget {
  const AdminPreviousDisasterImagePick({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AdminPreviousDisasterController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Call pickImages method when the image button is pressed
        controller.pickImages();
      },
      child: Obx(() {
        final List<String> disasterImages = controller.disasterImages.toList();
        return SizedBox(
          height: TSizes.disasterImageSize,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1.0,
            ),
            itemCount: disasterImages.length + 1, // Add 1 for the add button
            itemBuilder: (context, index) {
              if (index == disasterImages.length) {
                // Add button
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                  ),
                  width: double.infinity,
                  height: TSizes.disasterImageSize,
                  child: const Icon(Iconsax.camera, size: TSizes.iconMd),
                );
              } else {
                // Display selected image
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                      child: Image.file(
                        File(disasterImages[index]),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          controller.disasterImages.removeAt(index);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.6),
                          radius: 12,
                          child: const Icon(Icons.close, color: Colors.white, size: 16),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        );
      }),
    );
  }
}
