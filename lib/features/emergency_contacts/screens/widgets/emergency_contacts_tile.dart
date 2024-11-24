import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:red_zone/features/personalization/controller/user_controller.dart';
import 'package:red_zone/utils/constants/sizes.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../common/widgets/shimmers/shimmer.dart';

class TEmergencyContactsTile extends StatelessWidget {
  const TEmergencyContactsTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () {
              if (controller.profileLoading.value) {
                return const TShimmerEffect(width: 80, height: 15);
              } else {
                return Text(controller.user.value.fullName, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.white));
              }
            },
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 4),
          Text("Emergency Contacts", style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)),
        ],
      ),
      actions: [TCartCounterIcon(onPressed: () {}, iconColor: TColors.white)],
    );
  }
}
