import 'package:flutter/material.dart';
import 'package:red_zone/features/personalization/controller/user_controller.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../utils/constants/text_strings.dart';
import 'package:get/get.dart';

import '../../../../admin_panel/screens/admin_chat/chat_screen.dart';

class TAdminHomeAppBar extends StatelessWidget {
  const TAdminHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey)),
          Obx(
            () {
              if (controller.profileLoading.value) {
                return const TShimmerEffect(width: 80, height: 15);
              } else {
                return Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white));
              }
            },
          ),
        ],
      ),
      actions: [TCartCounterIcon(onPressed: () => Get.to(const AdminChatScreen()), iconColor: TColors.white)],
    );
  }
}
