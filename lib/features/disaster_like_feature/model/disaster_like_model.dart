import 'package:cloud_firestore/cloud_firestore.dart';

import '../../disaster_main/models/disaster_model.dart';
import '../../personalization/models/user_model.dart'; // Import UserModel

class Like {
  final String id;
  final String userId;
  final String postId;
  final DateTime likedAt;
  final UserModel user; // Change this to UserModel
  final DisasterModel post; // Change this to DisasterModel

  Like({
    required this.id,
    required this.userId,
    required this.postId,
    required this.likedAt,
    required this.user,
    required this.post,
  });

  static Like empty() => Like(
        id: '',
        userId: '',
        postId: '',
        likedAt: DateTime.now(),
        user: UserModel.empty(),
        post: DisasterModel.empty(),
      );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'postId': postId,
      'likedAt': likedAt,
      'post': post.toJson(),
      'user': user.toJson(),
    };
  }

  factory Like.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return Like.empty();
    final data = document.data()!;

    return Like(
      id: document.id,
      userId: data['userId'] ?? '',
      postId: data['postId'] ?? '',
      likedAt: (data['likedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      user: UserModel.fromSnapshot(data['user']),
      post: DisasterModel.fromSnapshot(data['post']),
    );
  }

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['id'],
      userId: json['userId'],
      postId: json['postId'],
      likedAt: json['likedAt'],
      user: UserModel.fromJson(json['user']),
      post: DisasterModel.fromJson(json['post']),
    );
  }
}
