import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class AdminChatMessages extends StatelessWidget {
  const AdminChatMessages({Key? key}) : super(key: key);

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

            return AdminMessageBubble(
              userImage: chatMessage['userImage'],
              username: chatMessage['username'],
              message: chatMessage['text'],
              isMe: authenticatedUser.uid == chatMessage['userId'],
              canDelete: true, // Allow deletion for any message
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
      print('Error deleting message: $error');
    }
  }
}
