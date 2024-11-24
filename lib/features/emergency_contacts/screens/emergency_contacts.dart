import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_zone/common/widgets/appbar/appbar.dart';
import 'package:red_zone/common/widgets/appbar/tabbar.dart';
import 'package:red_zone/features/emergency_contacts/controller/contact_controller.dart';
import 'package:red_zone/features/emergency_contacts/model/contact_model.dart';
import 'package:red_zone/features/emergency_contacts/screens/widgets/category_tab.dart';
import 'package:red_zone/utils/helpers/helper_functions.dart';
import '../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../chat_message/screen/chat_screen.dart';

class EmergencyContacts extends StatelessWidget {
  const EmergencyContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactController = Get.put(ContactController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text('Emergency Contacts', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCartCounterIcon(onPressed: () => Get.to(const ChatScreen()), iconColor: dark ? TColors.white : TColors.dark),
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
                            children: const [
                              SizedBox(height: TSizes.spaceBtwItems),
                              // Search Bar
                              TSearchContainer(
                                text: "Emergency Contacts",
                                showBackground: false,
                                showBorder: true,
                                padding: EdgeInsets.zero,
                              ),
                              SizedBox(height: TSizes.spaceBtwSections),
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
