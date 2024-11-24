import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:red_zone/common/widgets/appbar/appbar.dart';
import 'package:red_zone/common/widgets/custom_shapes/containers/section_heading.dart';
import 'package:red_zone/utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/admin_panel/admin_primary_header_container.dart';
import '../../../../common/widgets/admin_panel/admin_setting_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../help_and_support/screen/help_and_support.dart';
import '../../../personalization/screens/profile/profile.dart';
import '../admin_emergency_contacts/admin_remove_emergency_contacts.dart';
import 'all_posts_list/all_posts_list.dart';
import 'all_registered_users/registered_users.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            TAdminPrimaryHeaderContainer(
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
                  TAdminSettingsMenuTile(icon: Iconsax.settings_copy, title: 'Settings and Privacy', subtitle: 'Change your privacy settings', onTap: () => Get.to(() => const ProfileScreen())),
                  TAdminSettingsMenuTile(icon: Iconsax.user, title: 'All Registered Users', subtitle: 'Removing or banning users', onTap: () => Get.to(() => const RegisteredUsersScreen())),
                  TAdminSettingsMenuTile(icon: Iconsax.card_add, title: 'All Posts List', subtitle: 'Users Posts deleting or banning', onTap: () => Get.to(() => const AllPostsListScreen())),
                  TAdminSettingsMenuTile(
                      icon: Iconsax.mobile, title: 'All Emergency Contacts', subtitle: 'Remove unwanted emergency contacts', onTap: () => Get.to(() => const AllEmergencyContactsScreen())),
                  TAdminSettingsMenuTile(icon: Iconsax.support, title: 'Help and Support', subtitle: '24/7 supporting and helping', onTap: () => Get.to(() => const HelpAndSupportScreen())),

                  /// -- App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TAdminSettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subtitle: 'Upload data to your cloud firebase'),

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
    return TAdminSettingsMenuTile(
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
