import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class AdminMessageBubble extends StatelessWidget {
  final String? userImage;
  final String? username;
  final String message;
  final bool isMe;
  final bool canDelete; // Indicates whether the message can be deleted
  final VoidCallback onDelete;

  const AdminMessageBubble({
    Key? key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
    required this.canDelete,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // Check if the message can be deleted and if it's sent by the current user
        if (canDelete) {
          _showDeleteConfirmationDialog(context);
        }
      },
      child: Stack(
        children: [
          if (userImage != null)
            Positioned(
              top: 15,
              right: isMe ? 0 : null,
              child: CircleAvatar(
                backgroundImage: NetworkImage(userImage!),
                radius: 23,
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 46),
            child: Row(
              mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),
                    if (username != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 13,
                          right: 13,
                        ),
                        child: Text(
                          username!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        color: isMe ? Colors.green[50] : TColors.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: !isMe ? Radius.zero : const Radius.circular(12),
                          topRight: isMe ? Radius.zero : const Radius.circular(12),
                          bottomLeft: const Radius.circular(12),
                          bottomRight: const Radius.circular(12),
                        ),
                      ),
                      constraints: const BoxConstraints(maxWidth: 200),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 14,
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 12,
                      ),
                      child: Text(
                        message,
                        style: TextStyle(
                          height: 1.3,
                          color: isMe ? TColors.black : TColors.light,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Message"),
          content: const Text("Are you sure you want to delete this message?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                onDelete(); // Call the onDelete callback to delete the message
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
