import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_zone/common/widgets/appbar/appbar.dart';
import 'package:red_zone/common/widgets/appbar/tabbar.dart';
import 'package:red_zone/features/admin_panel/screens/admin_emergency_contacts/admin_add_emergency_contacts_screen.dart';
import 'package:red_zone/features/emergency_contacts/controller/contact_controller.dart';
import 'package:red_zone/features/emergency_contacts/model/contact_model.dart';
import 'package:red_zone/features/emergency_contacts/screens/widgets/category_tab.dart';
import 'package:red_zone/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../admin_chat/chat_screen.dart';

class AdminEmergencyContactsScreen extends StatelessWidget {
  const AdminEmergencyContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactController = Get.put(ContactController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text('Emergency Contacts', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCartCounterIcon(onPressed: () => Get.to(const AdminChatScreen()), iconColor: dark ? TColors.white : TColors.dark),
        ],
      ),
      body: Obx(() {
        final contacts = contactController.contactList;
        final groupedContacts = groupContactsByCategory(contacts);

        return contacts.isEmpty
            ? const Center(child: CircularProgressIndicator()) // Show loading indicator while contacts are being fetched
            : DefaultTabController(
                length: groupedContacts.length,
                child: NestedScrollView(
                  headerSliverBuilder: (_, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        expandedHeight: 170, // Space between appbar and tab bar
                        automaticallyImplyLeading: false,
                        backgroundColor: dark ? TColors.black : TColors.white,
                        flexibleSpace: Padding(
                          padding: const EdgeInsets.all(20),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              const SizedBox(height: TSizes.spaceBtwItems),
                              // Search Bar
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                                child: Container(
                                  width: TDeviceUtils.getScreenWidth(context),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                                    border: Border.all(color: TColors.grey),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Add Emergency Contacts',
                                        style: TextStyle(
                                          color: TColors.darkerGrey,
                                          fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle, color: TColors.darkerGrey),
                                        onPressed: () => Get.to(() => const AdminAddEmergencyContactsScreen()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: TSizes.spaceBtwSections),
                            ],
                          ),
                        ),
                        // Tabs
                        bottom: TTabBar(
                          tabs: groupedContacts.keys.map((category) => Tab(child: Text(category))).toList(),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: groupedContacts.values.map((contacts) => TCategoryTab(contacts: contacts)).toList(),
                  ),
                ),
              );
      }),
    );
  }

  Map<String, List<ContactModel>> groupContactsByCategory(List<ContactModel> contacts) {
    final Map<String, List<ContactModel>> groupedContacts = {};
    for (var contact in contacts) {
      if (!groupedContacts.containsKey(contact.emergencyServiceCategory)) {
        groupedContacts[contact.emergencyServiceCategory] = [];
      }
      groupedContacts[contact.emergencyServiceCategory]!.add(contact);
    }
    return groupedContacts;
  }
}
