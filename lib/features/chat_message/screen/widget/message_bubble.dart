// import 'package:flutter/material.dart';
// import 'package:red_zone/utils/constants/colors.dart';
//
// class MessageBubble extends StatelessWidget {
//   const MessageBubble.first({
//     super.key,
//     required this.userImage,
//     required this.username,
//     required this.message,
//     required this.isMe,
//   }) : isFirstInSequence = true;
//
//   const MessageBubble.next({
//     super.key,
//     required this.message,
//     required this.isMe,
//   })  : isFirstInSequence = false,
//         userImage = null,
//         username = null;
//
//   final bool isFirstInSequence;
//
//   final String? userImage;
//
//   final String? username;
//   final String message;
//
//   final bool isMe;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Stack(
//       children: [
//         if (userImage != null)
//           Positioned(
//             top: 15,
//             right: isMe ? 0 : null,
//             child: CircleAvatar(
//               backgroundImage: NetworkImage(
//                 userImage!,
//               ),
//               //backgroundColor: theme.colorScheme.primary.withAlpha(180),
//               backgroundColor: TColors.primary.withAlpha(180),
//               radius: 23,
//             ),
//           ),
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 46),
//           child: Row(
//             mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//             children: [
//               Column(
//                 crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                 children: [
//                   if (isFirstInSequence) const SizedBox(height: 18),
//                   if (username != null)
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 13,
//                         right: 13,
//                       ),
//                       child: Text(username!, style: Theme.of(context).textTheme.bodySmall),
//                     ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: isMe ? Colors.green[50] : TColors.primary,
//                       borderRadius: BorderRadius.only(
//                         topLeft: !isMe && isFirstInSequence ? Radius.zero : const Radius.circular(12),
//                         topRight: isMe && isFirstInSequence ? Radius.zero : const Radius.circular(12),
//                         bottomLeft: const Radius.circular(12),
//                         bottomRight: const Radius.circular(12),
//                       ),
//                     ),
//                     constraints: const BoxConstraints(maxWidth: 200),
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 10,
//                       horizontal: 14,
//                     ),
//                     margin: const EdgeInsets.symmetric(
//                       vertical: 4,
//                       horizontal: 12,
//                     ),
//                     child: Text(
//                       message,
//                       style: TextStyle(
//                         height: 1.3,
//                         color: isMe ? TColors.black : TColors.light,
//                       ),
//                       softWrap: true,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';

class MessageBubble extends StatelessWidget {
  final String? userImage;
  final String? username;
  final String message;
  final bool isMe;
  final bool canDelete;
  final VoidCallback onDelete;

  const MessageBubble({
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
        if (canDelete && isMe) {
          _showDeleteConfirmation(context);
        }
      },
      child: Stack(
        children: [
          if (userImage != null) // Add null check here
            Positioned(
              top: 15,
              right: isMe ? 0 : null,
              child: CircleAvatar(
                backgroundImage: NetworkImage(userImage!), // Add null check here
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
                    if (username != null) // Add null check here
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 13,
                          right: 13,
                        ),
                        child: Text(username!, style: Theme.of(context).textTheme.bodySmall), // Add null check here
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

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Message'),
          content: const Text('Are you sure you want to delete this message?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete();
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

// All Messages can delete - Admin Feature
// import 'package:flutter/material.dart';
//
// class MessageBubble extends StatelessWidget {
//   final String? userImage;
//   final String? username;
//   final String message;
//   final bool isMe;
//   final VoidCallback onDelete;
//
//   const MessageBubble({
//     Key? key,
//     required this.userImage,
//     required this.username,
//     required this.message,
//     required this.isMe,
//     required this.onDelete,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onLongPress: () {
//         _showDeleteConfirmationDialog(context);
//       },
//       child: Stack(
//         children: [
//           if (userImage != null) // Add null check here
//             Positioned(
//               top: 15,
//               right: isMe ? 0 : null,
//               child: CircleAvatar(
//                 backgroundImage: NetworkImage(userImage!), // Add null check here
//                 radius: 23,
//               ),
//             ),
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 46),
//             child: Row(
//               mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 18),
//                     if (username != null) // Add null check here
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           left: 13,
//                           right: 13,
//                         ),
//                         child: Text(username!, style: Theme.of(context).textTheme.bodyText1), // Add null check here
//                       ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: isMe ? Colors.green[50] : Colors.blue[50],
//                         borderRadius: BorderRadius.only(
//                           topLeft: !isMe ? Radius.zero : const Radius.circular(12),
//                           topRight: isMe ? Radius.zero : const Radius.circular(12),
//                           bottomLeft: const Radius.circular(12),
//                           bottomRight: const Radius.circular(12),
//                         ),
//                       ),
//                       constraints: const BoxConstraints(maxWidth: 200),
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 14,
//                       ),
//                       margin: const EdgeInsets.symmetric(
//                         vertical: 4,
//                         horizontal: 12,
//                       ),
//                       child: Text(
//                         message,
//                         style: TextStyle(
//                           height: 1.3,
//                           color: isMe ? Colors.black : Colors.white,
//                         ),
//                         softWrap: true,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showDeleteConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Delete Message"),
//           content: Text("Are you sure you want to delete this message?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("No"),
//             ),
//             TextButton(
//               onPressed: () {
//                 onDelete(); // Call the onDelete callback to delete the message
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("Yes"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
