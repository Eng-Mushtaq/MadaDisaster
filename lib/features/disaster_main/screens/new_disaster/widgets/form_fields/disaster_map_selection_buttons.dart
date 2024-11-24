// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../../../../../../utils/constants/sizes.dart';
// import '../../../../../../utils/constants/text_strings.dart';
// import '../../../../controller/disaster_controller.dart';
//
// class MapSelectionButtons extends StatelessWidget {
//   const MapSelectionButtons({
//     super.key,
//     required this.controller,
//   });
//
//   final DisasterController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: OutlinedButton(
//             onPressed: () => controller.getLocation(),
//             child: const Text(TTexts.selectOnCurrentLocation),
//           ),
//         ),
//         const SizedBox(width: TSizes.spaceBtwInputFields),
//
//         // onSelectMap button
//         Expanded(
//           child: OutlinedButton(
//             onPressed: () {
//               // Open Google Map screen and set callback functions
//               controller.openGoogleMapScreen(
//                 onSaveCustomMarkerCallback: () {},
//                 onLocationPicked: (LatLng? pickedLocation) {
//                   controller.updateSelectedLocation(pickedLocation);
//
//                   Get.snackbar(
//                     'Location Picked',
//                     'Selected location: ${pickedLocation?.latitude}, ${pickedLocation?.longitude}',
//                     snackPosition: SnackPosition.BOTTOM,
//                   );
//                 },
//               );
//             },
//             child: const Text(TTexts.selectOnMap),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../controller/disaster_controller.dart';
import '../../../../models/disaster_model.dart';
import '../google_map_screen.dart';

class MapSelectionButtons extends StatelessWidget {
  const MapSelectionButtons({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DisasterController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => controller.getLocation(),
            child: const Text(TTexts.selectOnCurrentLocation),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwInputFields),

        // onSelectMap button
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              // Open Google Map screen and set callback functions
              controller.openGoogleMapScreen(
                onSaveCustomMarkerCallback: () {},
                onLocationPicked: (LatLng? pickedLocation) async {
                  controller.updateSelectedLocation(pickedLocation);
                  Get.snackbar(
                    'Location Picked',
                    'Selected location: ${pickedLocation?.latitude}, ${pickedLocation?.longitude}',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              );
            },
            child: Obx(() {
              // Show the button label based on whether a location is selected
              return Text(controller.pickedLocation.value != null ? TTexts.changeLocation : TTexts.selectOnMap);
            }),
          ),
        ),
      ],
    );
  }
}
