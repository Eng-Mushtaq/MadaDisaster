// import 'dart:io' if (dart.library.html) 'dart:html';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../../../../../utils/constants/sizes.dart';
// import '../../../../../../utils/constants/text_strings.dart';
// import '../../../../controller/disaster_controller.dart';
//
// class DisasterMapSelection extends StatelessWidget {
//   const DisasterMapSelection({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(DisasterController());
//
//     // Display the image of the disaster
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
//       ),
//       width: double.infinity,
//       height: TSizes.disasterImageSize,
//       child: Obx(() {
//         // Display the map image if location is selected
//         if (controller.locationImage.value.isNotEmpty) {
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
//             child: Image.network(
//               controller.locationImage.value,
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: TSizes.disasterImageSize,
//             ),
//           );
//         } else if (controller.googleLocationImage.value.isNotEmpty) {
//           // Display the map image if location is selected
//           return ClipRRect(
//               borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
//               child: Image.network(
//                 controller.googleLocationImage.value,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: TSizes.disasterImageSize,
//               ));
//         } else {
//           // Display icon or image when no location is selected
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
//             child: Obx(() {
//               if (controller.locationImage.value.isNotEmpty) {
//                 // Display the image if location image is available
//                 return Image.network(
//                   controller.locationImage.value,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: TSizes.disasterImageSize,
//                 );
//               } else if (controller.googleMapLocation.value.isNotEmpty) {
//                 // Display the map image if location is selected
//                 return Image.network(
//                   controller.googleMapLocation.value,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: TSizes.disasterImageSize,
//                 );
//               } else {
//                 // Display icon when no location is selected
//                 return IconButton(
//                   icon: const Icon(Iconsax.map, size: TSizes.iconMd),
//                   tooltip: TTexts.cancel,
//                   onPressed: () {
//                     // Open the Google Map screen and set the callback functions
//                     controller.openGoogleMapScreen(
//                       onSaveCustomMarkerCallback: () {
//                         Get.snackbar(
//                           'Marker Saved',
//                           'Custom marker saved successfully!',
//                           snackPosition: SnackPosition.BOTTOM,
//                         );
//                       },
//                       onLocationPicked: (LatLng? pickedLocation) {
//                         controller.updateSelectedLocation(pickedLocation);
//
//                         Get.snackbar(
//                           'Location Picked',
//                           'Selected location: ${pickedLocation?.latitude}, ${pickedLocation?.longitude}',
//                           snackPosition: SnackPosition.BOTTOM,
//                         );
//                       },
//                     );
//                   },
//                 );
//               }
//             }),
//           );
//         }
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../controller/admin_previous_disaster_controller.dart';

class AdminPreviousDisasterMapSelection extends StatelessWidget {
  const AdminPreviousDisasterMapSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminPreviousDisasterController());

    // Display the image of the disaster
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
      ),
      width: double.infinity,
      height: TSizes.disasterImageSize,
      child: Obx(() {
        // Display the map image if location is selected
        if (controller.locationImage.value.isNotEmpty) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            child: Image.network(
              controller.locationImage.value,
              fit: BoxFit.cover,
              width: double.infinity,
              height: TSizes.disasterImageSize,
            ),
          );
        } else if (controller.googleLocationImage.value.isNotEmpty) {
          // Display the map image if location is selected
          return ClipRRect(
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              child: Image.network(
                controller.googleLocationImage.value,
                fit: BoxFit.cover,
                width: double.infinity,
                height: TSizes.disasterImageSize,
              ));
        } else {
          // Display icon or shimmer when no location is selected
          return ClipRRect(
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            child: controller.isLoading.value
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: TSizes.disasterImageSize,
                      color: Colors.white,
                    ),
                  )
                : Obx(() {
                    if (controller.locationImage.value.isNotEmpty) {
                      // Display the image if location image is available
                      return Image.network(
                        controller.locationImage.value,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: TSizes.disasterImageSize,
                      );
                    } else if (controller.googleMapLocation.value.isNotEmpty) {
                      // Display the map image if location is selected
                      return Image.network(
                        controller.googleMapLocation.value,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: TSizes.disasterImageSize,
                      );
                    } else {
                      // Display icon when no location is selected
                      return IconButton(
                        icon: const Icon(Iconsax.map, size: TSizes.iconMd),
                        tooltip: TTexts.cancel,
                        onPressed: () {
                          // Open the Google Map screen and set the callback functions
                          controller.openGoogleMapScreen(
                            onSaveCustomMarkerCallback: () {
                              Get.snackbar(
                                'Marker Saved',
                                'Custom marker saved successfully!',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            onLocationPicked: (LatLng? pickedLocation) {
                              controller.updateSelectedLocation(pickedLocation);

                              Get.snackbar(
                                'Location Picked',
                                'Selected location: ${pickedLocation?.latitude}, ${pickedLocation?.longitude}',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                          );
                        },
                      );
                    }
                  }),
          );
        }
      }),
    );
  }
}
