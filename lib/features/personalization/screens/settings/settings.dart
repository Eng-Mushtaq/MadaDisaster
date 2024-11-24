import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:red_zone/common/widgets/appbar/appbar.dart';
import 'package:red_zone/common/widgets/custom_shapes/containers/section_heading.dart';
import 'package:red_zone/utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../help_and_support/screen/help_and_support.dart';
import '../my_posts/user_all_posts.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white)),
                  ),
                  TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            //Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// --Account Settings
                  const TSectionHeading(title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(icon: Iconsax.settings_copy, title: 'Settings and Privacy', subtitle: 'Change your privacy settings', onTap: () => Get.to(() => const ProfileScreen())),
                  TSettingsMenuTile(icon: Iconsax.card_add, title: 'My Posts', subtitle: 'Preview your all posts and delete', onTap: () => Get.to(() => const UserAllPostsListScreen())),
                  const TSettingsMenuTile(icon: Iconsax.location, title: 'My Location', subtitle: 'Set your location'),
                  TSettingsMenuTile(icon: Iconsax.support, title: 'Help and Support', subtitle: '24/7 support and help', onTap: () => Get.to(() => const HelpAndSupportScreen())),

                  /// -- App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subtitle: 'Upload data to your cloud firebase'),

                  const AdminSettingsSwitch(
                    icon: Icons.location_on,
                    title: 'Geo Location',
                    subtitle: 'Set recommended location',
                    switchKey: 'geo_location',
                  ),
                  const AdminSettingsSwitch(
                    icon: Icons.security,
                    title: 'Safe Mode',
                    subtitle: 'Set recommended location',
                    switchKey: 'safe_mode',
                  ),
                  const AdminSettingsSwitch(
                    icon: Icons.image,
                    title: 'HD Image Quality',
                    subtitle: 'Set recommended location',
                    switchKey: 'hd_image_quality',
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// - Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: () => AuthenticationRepository.instance.logout(), child: const Text('Logout')),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AdminSettingsSwitch extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String switchKey;

  const AdminSettingsSwitch({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.switchKey,
    Key? key,
  }) : super(key: key);

  @override
  _AdminSettingsSwitchState createState() => _AdminSettingsSwitchState();
}

class _AdminSettingsSwitchState extends State<AdminSettingsSwitch> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = GetStorage().read(widget.switchKey) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TSettingsMenuTile(
      icon: widget.icon,
      title: widget.title,
      subtitle: widget.subtitle,
      trailing: Switch(
        value: value,
        onChanged: (newValue) {
          setState(() {
            value = newValue;
          });
          GetStorage().write(widget.switchKey, newValue);
        },
      ),
    );
  }
}
