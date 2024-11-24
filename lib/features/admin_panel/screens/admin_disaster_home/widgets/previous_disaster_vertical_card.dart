// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:intl/intl.dart';
//
// import 'package:red_zone/common/widgets/images/rounded_container.dart';
// import 'package:red_zone/features/disaster_main/screens/disaster_details/disaster_detail.dart';
// import 'package:red_zone/utils/constants/colors.dart';
// import 'package:red_zone/utils/helpers/helper_functions.dart';
// import '../../../../../common/styles/product_title_text.dart';
// import '../../../../../common/styles/shadows.dart';
// import '../../../../../common/widgets/custom_shapes/containers/circular_image.dart';
// import '../../../../../common/widgets/images/rounded_disaster_image.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../model/previous_disaster_model.dart';
// import '../../previous_disaster_details/previous_disaster_details.dart';
//
// class TAdminPreviousDisasterVerticalCard extends StatelessWidget {
//   const TAdminPreviousDisasterVerticalCard({super.key, required this.disaster});
//
//   final PreviousDisasterModel disaster;
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//
//     String formattedDate = DateFormat('yyyy-MM-dd').format(disaster.createdAt);
//     String formattedTime = DateFormat('HH:mm a').format(disaster.createdAt);
//     String formattedDateTime = '$formattedDate at $formattedTime';
//
//     return GestureDetector(
//       onTap: () => Get.to(() => AdminPreviousDisasterDetails(disaster: disaster)),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(1),
//         decoration: BoxDecoration(
//           boxShadow: [TShadowStyle.verticalShadow],
//           borderRadius: BorderRadius.circular(TSizes.productImageRadius),
//           color: dark ? TColors.darkerGrey : TColors.white,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ListTile(
//               // User Profile Image
//               leading: TCircularImage(
//                 image: disaster.user!.profilePicture,
//                 width: 50,
//                 height: 50,
//                 padding: 0,
//                 isNetworkImage: true,
//               ),
//               title: TProductTitleText(title: '${disaster.disasterType} in ${disaster.disasterDistrict}, ${disaster.disasterProvince}', smallSize: false, maxLines: 1),
//               subtitle: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(disaster.user!.fullName, overflow: TextOverflow.ellipsis),
//                     const SizedBox(width: 4),
//                     const Icon(Iconsax.verify, color: TColors.primary, size: TSizes.iconXs),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   formattedDateTime,
//                   style: Theme.of(context).textTheme.labelSmall,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ]),
//             ),
//             const SizedBox(height: 8),
//             Text(disaster.disasterDescription, overflow: TextOverflow.ellipsis, maxLines: 3),
//             const SizedBox(height: 8),
//             TRoundedContainer(
//               height: 370,
//               padding: const EdgeInsets.all(8),
//               backgroundColor: dark ? TColors.dark : TColors.light,
//               child: Stack(
//                 children: [
//                   TRoundedDisasterImage(
//                     imageUrl: disaster.disasterImageUrls?.isNotEmpty == true ? disaster.disasterImageUrls!.first : '', // Check if the list is not empty before accessing its first element
//                     applyImageRadius: true,
//                     isNetworkImage: true,
//                     width: double.infinity,
//                     height: 370,
//                     fit: BoxFit.cover,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Implement Like functionality
//                   },
//                   style: ElevatedButton.styleFrom(
//                     shape: const StadiumBorder(),
//                     backgroundColor: TColors.primary,
//                     minimumSize: const Size(150, 50),
//                     padding: const EdgeInsets.all(8),
//                   ),
//                   icon: const Icon(Iconsax.heart),
//                   label: const Text('Like'),
//                 ),
//                 const SizedBox(width: 8),
//                 OutlinedButton(
//                   onPressed: () => Get.to(() => AdminPreviousDisasterDetails(disaster: disaster)),
//                   style: OutlinedButton.styleFrom(
//                     shape: const StadiumBorder(),
//                     minimumSize: const Size(150, 50),
//                     padding: const EdgeInsets.all(2),
//                   ),
//                   child: const Text('Preview'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:red_zone/common/styles/product_title_text.dart';
import 'package:red_zone/common/widgets/custom_shapes/containers/circular_image.dart';
import 'package:red_zone/common/widgets/images/rounded_disaster_image.dart';
import 'package:red_zone/utils/constants/colors.dart';
import 'package:red_zone/utils/helpers/helper_functions.dart';
import 'package:red_zone/utils/constants/sizes.dart';
import '../../../model/previous_disaster_model.dart';
import '../../previous_disaster_details/previous_disaster_details.dart';

class TAdminPreviousDisasterVerticalCard extends StatelessWidget {
  const TAdminPreviousDisasterVerticalCard({Key? key, required this.disaster}) : super(key: key);

  final PreviousDisasterModel disaster;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    String formattedDate = DateFormat('yyyy-MM-dd').format(disaster.createdAt);
    String formattedTime = DateFormat('HH:mm a').format(disaster.createdAt);
    String formattedDateTime = '$formattedDate at $formattedTime';

    return GestureDetector(
      onTap: () => Get.to(() => AdminPreviousDisasterDetails(disaster: disaster)),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: TCircularImage(
                  image: disaster.user!.profilePicture,
                  width: 50,
                  height: 50,
                  padding: 0,
                  isNetworkImage: true,
                ),
                title: TProductTitleText(
                  title: '${disaster.disasterType} in ${disaster.disasterDistrict}, ${disaster.disasterProvince}',
                  smallSize: false,
                  maxLines: 1,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(disaster.user!.fullName, overflow: TextOverflow.ellipsis),
                        const SizedBox(width: 4),
                        const Icon(Iconsax.verify, color: TColors.primary, size: TSizes.iconXs),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formattedDateTime,
                      style: Theme.of(context).textTheme.titleSmall, // Changed to caption style
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 40, // Set a fixed height for the description container
                child: Text(
                  disaster.disasterDescription,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2, // Limit to two lines
                ),
              ),
              const SizedBox(height: 8),
              TRoundedDisasterImage(
                imageUrl: disaster.disasterImageUrls?.isNotEmpty == true ? disaster.disasterImageUrls!.first : '',
                applyImageRadius: true,
                isNetworkImage: true,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Implement Like functionality
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.red.shade800,
                      minimumSize: const Size(150, 50),
                      padding: const EdgeInsets.all(8),
                    ),
                    icon: const Icon(Iconsax.heart),
                    label: const Text('Like'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () => Get.to(() => AdminPreviousDisasterDetails(disaster: disaster)),
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: const Size(150, 50),
                      padding: const EdgeInsets.all(2),
                    ),
                    child: const Text('Preview'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
