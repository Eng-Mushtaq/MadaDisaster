import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_zone/common/widgets/appbar/appbar.dart';
import 'package:red_zone/features/personalization/models/user_model.dart';
import 'package:red_zone/utils/helpers/helper_functions.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../chat_message/screen/chat_screen.dart';
import '../../../controller/all_registered_users_controller/all_registered_users_controller.dart';
import '../../admin_chat/chat_screen.dart';

class RegisteredUsersScreen extends StatelessWidget {
  const RegisteredUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(RegisteredUsersController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: const Text('All Registered Users'),
        actions: [
          TCartCounterIcon(onPressed: () => Get.to(const AdminChatScreen()), iconColor: dark ? TColors.white : TColors.dark),
        ],
      ),
      body: Obx(() {
        final List<UserModel> users = userController.userList;

        return users.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final UserModel user = users[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm"),
                            content: Text("Are you sure you want to delete ${user.email}?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text("DELETE"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text("CANCEL"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      userController.deleteUser(user.id);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePicture),
                      ),
                      title: Text(user.fullName),
                      subtitle: Text(user.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.swipe_left),
                        onPressed: () {
                          // Handle message button pressed
                          // For example, navigate to a chat screen with this user
                        },
                      ),
                      onTap: () {
                        // Handle tap on user item
                        // For example, navigate to a user profile screen
                      },
                    ),
                  );
                },
              );
      }),
    );
  }
}
