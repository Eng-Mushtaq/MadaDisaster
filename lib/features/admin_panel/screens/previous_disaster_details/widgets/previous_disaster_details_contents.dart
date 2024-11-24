import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../../common/styles/product_title_text.dart';
import '../../../../../../common/widgets/custom_shapes/containers/circular_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../model/previous_disaster_model.dart';

class TPreviousDisasterDetails extends StatelessWidget {
  const TPreviousDisasterDetails({
    super.key,
    required this.disaster,
  });

  final PreviousDisasterModel disaster;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(disaster.createdAt);
    String formattedTime = DateFormat('HH:mm a').format(disaster.createdAt);
    String formattedDateTime = '$formattedDate at $formattedTime';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          // User Profile Image
          leading: TCircularImage(
            image: disaster.user!.profilePicture,
            width: 50,
            height: 50,
            padding: 0,
            isNetworkImage: true,
          ),
          title: TProductTitleText(title: '${disaster.disasterType} in ${disaster.disasterDistrict}, ${disaster.disasterProvince}', smallSize: false, maxLines: 1),
          subtitle: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              style: Theme.of(context).textTheme.labelSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ]),
        ),
        const SizedBox(height: 8),

        // Disaster Discription
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Text(disaster.disasterDescription, textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }
}
