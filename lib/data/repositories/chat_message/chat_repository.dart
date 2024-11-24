import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessageRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String message) async {
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await _getUserData(user.uid);

    await _firestore.collection('Chat').add({
      'text': message,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['Username'],
      'userImage': userData['ProfilePicture'],
    });
  }

  Future<Map<String, dynamic>> _getUserData(String userId) async {
    final userData = await _firestore.collection('Users').doc(userId).get();
    return userData.data() as Map<String, dynamic>;
  }
}
