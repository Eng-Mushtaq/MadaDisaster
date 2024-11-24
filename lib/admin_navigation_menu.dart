import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:red_zone/utils/constants/colors.dart';
import 'package:red_zone/utils/helpers/helper_functions.dart';

import 'features/admin_panel/screens/admin_disaster_home/admin_disaster_home.dart';
import 'features/admin_panel/screens/admin_emergency_contacts/admin_emergency_contact_screen.dart';
import 'features/admin_panel/screens/admin_home/admin_home_screen.dart';
import 'features/admin_panel/screens/admin_profile/admin_settings.dart';

class AdminNavigationMenu extends StatelessWidget {
  const AdminNavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminNavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : TColors.white,
          indicatorColor: darkMode ? TColors.white.withOpacity(0.1) : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.map_1), label: 'Disasters'),
            NavigationDestination(icon: Icon(Iconsax.call_add), label: 'Emergency'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class AdminNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const AdminHomeScreen(),
    const AdminDisasterHomeScreen(),
    const AdminEmergencyContactsScreen(),
    const AdminSettingsScreen(),
  ];
}
