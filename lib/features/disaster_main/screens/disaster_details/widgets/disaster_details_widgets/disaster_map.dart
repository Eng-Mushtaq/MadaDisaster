import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/disaster_model.dart';
import 'disaster_googlemap_screen.dart';
//
// class TDisasterMap extends StatelessWidget {
//   const TDisasterMap({
//     super.key,
//     required this.disaster,
//   });
//
//   final DisasterModel disaster;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to Google Maps screen using latitude and longitude
//         final latitude = disaster.disasterLocation.latitude;
//         final longitude = disaster.disasterLocation.longitude;
//
//         // Navigate to Google Maps screen with specified latitude and longitude
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => DisasterGoogleMapsScreen(latitude: latitude, longitude: longitude),
//           ),
//         );
//       },
//       child: FractionallySizedBox(
//         widthFactor: 1.0,
//         child: Container(
//           color: TColors.primary,
//           child: Column(children: [
//             Center(
//               child: (disaster.disasterLocation.latitude != null && disaster.disasterLocation.longitude != null)
//                   ? Image.network(
//                       'https://maps.googleapis.com/maps/api/staticmap?center=${disaster.disasterLocation.latitude},${disaster.disasterLocation.longitude}&zoom=15&size=600x300&markers=color:red%7C${disaster.disasterLocation.latitude},${disaster.disasterLocation.longitude}&key=AIzaSyBt4iFeic3dBUU-GJNBWNJLqQ3xNOiuZfI',
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       height: TSizes.disasterImageSize,
//                     )
//                   : Text('Disaster Map'),
//             ),
//             const SizedBox(height: TSizes.spaceBtwItems),
//             Text('Open Map', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TColors.white)),
//             const SizedBox(height: TSizes.spaceBtwItems),
//           ]),
//         ),
//       ),
//     );
//   }
// }
//
//

class TDisasterMap extends StatelessWidget {
  const TDisasterMap({
    Key? key,
    required this.disaster,
    required this.isLoading,
  }) : super(key: key);

  final DisasterModel disaster;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Google Maps screen using latitude and longitude
        final latitude = disaster.disasterLocation.latitude;
        final longitude = disaster.disasterLocation.longitude;

        // Navigate to Google Maps screen with specified latitude and longitude
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisasterGoogleMapsScreen(latitude: latitude, longitude: longitude),
          ),
        );
      },
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: Container(
          color: TColors.primary,
          child: isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: TSizes.disasterImageSize,
                    color: Colors.white,
                  ),
                )
              : Column(
                  children: [
                    Center(
                      child: (disaster.disasterLocation.latitude != null && disaster.disasterLocation.longitude != null)
                          ? Image.network(
                              'https://maps.googleapis.com/maps/api/staticmap?center=${disaster.disasterLocation.latitude},${disaster.disasterLocation.longitude}&zoom=15&size=600x300&markers=color:red%7C${disaster.disasterLocation.latitude},${disaster.disasterLocation.longitude}&key=AIzaSyBt4iFeic3dBUU-GJNBWNJLqQ3xNOiuZfI',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: TSizes.disasterImageSize,
                            )
                          : Text('Disaster Map'),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Text('Open Map', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TColors.white)),
                    const SizedBox(height: TSizes.spaceBtwItems),
                  ],
                ),
        ),
      ),
    );
  }
}
