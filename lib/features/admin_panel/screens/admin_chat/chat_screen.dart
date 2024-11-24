import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:red_zone/features/admin_panel/screens/admin_chat/widget/chat_message.dart';
import 'package:red_zone/features/admin_panel/screens/admin_chat/widget/new_chat_message.dart';
import 'package:red_zone/features/chat_message/screen/widget/chat_back_icon.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class AdminChatScreen extends StatefulWidget {
  const AdminChatScreen({super.key});

  @override
  State<AdminChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<AdminChatScreen> {
  void pushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('Chat');
  }

  @override
  void initState() {
    super.initState();
    pushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        title: Text('Admin Community Chat', style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          TChatBackIcon(onPressed: () => Navigator.of(context).pop(), iconColor: dark ? TColors.white : TColors.dark),
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: AdminChatMessages(),
          ),
          AdminNewMessage(),
        ],
      ),
    );
  }
}
