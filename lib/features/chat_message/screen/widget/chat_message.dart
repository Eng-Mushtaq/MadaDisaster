// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'message_bubble.dart';
//
// class ChatMessages extends StatelessWidget {
//   const ChatMessages({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final authenticatedUser = FirebaseAuth.instance.currentUser!;
//
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('Chat').orderBy('createdAt', descending: true).snapshots(),
//       builder: (context, chatSnapshot) {
//         if (chatSnapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
//           return const Center(
//             child: Text('No messages found.'),
//           );
//         }
//         if (chatSnapshot.hasError) {
//           return const Center(
//             child: Text('Something went wrong!'),
//           );
//         }
//         final loadedMessages = chatSnapshot.data!.docs;
//
//         return ListView.builder(
//           padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
//           reverse: true,
//           itemCount: loadedMessages.length,
//           itemBuilder: (context, index) {
//             final chatMessage = loadedMessages[index].data();
//             final nextChatMessage = index + 1 < loadedMessages.length ? loadedMessages[index + 1].data() : null;
//
//             final currentMessageUserId = chatMessage['userId'];
//             final nextMessageUserId = nextChatMessage != null ? nextChatMessage['userId'] : null;
//             final nextUserIsSame = nextMessageUserId == currentMessageUserId;
//
//             if (nextUserIsSame) {
//               return MessageBubble.next(
//                 message: chatMessage['text'],
//                 isMe: authenticatedUser.uid == currentMessageUserId,
//               );
//             } else {
//               return MessageBubble.first(
//                 userImage: chatMessage['userImage'],
//                 username: chatMessage['username'],
//                 message: chatMessage['text'],
//                 isMe: authenticatedUser.uid == currentMessageUserId,
//               );
//             }
//           },
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages found.'),
          );
        }
        if (chatSnapshot.hasError) {
          return const Center(
            child: Text('Something went wrong!'),
          );
        }
        final loadedMessages = chatSnapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
          reverse: true,
          itemCount: loadedMessages.length,
          itemBuilder: (context, index) {
            final chatMessage = loadedMessages[index].data();
            final nextChatMessage = index + 1 < loadedMessages.length ? loadedMessages[index + 1].data() : null;

            final currentMessageUserId = chatMessage['userId'];
            final nextMessageUserId = nextChatMessage != null ? nextChatMessage['userId'] : null;
            final nextUserIsSame = nextMessageUserId == currentMessageUserId;

            return MessageBubble(
              userImage: chatMessage['userImage'],
              username: chatMessage['username'],
              message: chatMessage['text'],
              isMe: authenticatedUser.uid == currentMessageUserId,
              canDelete: authenticatedUser.uid == currentMessageUserId, // Check if current user can delete this message
              onDelete: () => deleteMessage(loadedMessages[index].id),
            );
          },
        );
      },
    );
  }

  void deleteMessage(String documentId) {
    try {
      // Get a reference to the Firestore document
      final documentReference = FirebaseFirestore.instance.collection('Chat').doc(documentId);

      // Delete the document
      documentReference.delete();

      // Optional: Show a success message
      print('Message deleted successfully');
    } catch (error) {
      // Handle any errors that occur during the deletion process
      print('Error deleting message: $error');
      // Optional: Show an error message to the user
    }
  }
}
