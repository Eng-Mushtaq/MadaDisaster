import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../models/disaster_model.dart';
import '../../disaster_details/disaster_detail.dart';

class LikePreviewButtons extends StatefulWidget {
  const LikePreviewButtons({
    Key? key,
    required this.disaster,
  }) : super(key: key);

  final DisasterModel disaster;

  @override
  LikePreviewButtonsState createState() => LikePreviewButtonsState();
}

class LikePreviewButtonsState extends State<LikePreviewButtons> {
  int _likeCount = 0;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _getLikeCount();
    _checkIfLiked();
  }

  void _getLikeCount() {
    FirebaseFirestore.instance.collection('Likes').where('postId', isEqualTo: widget.disaster.id).get().then((querySnapshot) {
      setState(() {
        _likeCount = querySnapshot.size;
      });
    });
  }

  void _checkIfLiked() {
    FirebaseFirestore.instance.collection('Likes').where('postId', isEqualTo: widget.disaster.id).where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((querySnapshot) {
      setState(() {
        _isLiked = querySnapshot.size > 0;
      });
    });
  }

  void _toggleLike() {
    if (_isLiked) {
      FirebaseFirestore.instance.collection('Likes').where('postId', isEqualTo: widget.disaster.id).where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
        setState(() {
          _likeCount--;
          _isLiked = false;
        });
      });
    } else {
      FirebaseFirestore.instance.collection('Likes').add({
        'postId': widget.disaster.id,
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'likedAt': DateTime.now(),
        'userName': FirebaseAuth.instance.currentUser!.displayName ?? '',
      }).then((_) {
        setState(() {
          _likeCount++;
          _isLiked = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: _toggleLike,
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: _isLiked ? null : TColors.primary,
              minimumSize: const Size(150, 50),
              padding: const EdgeInsets.all(8),
            ),
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: _isLiked ? Colors.red : Colors.white,
            ),
            label: Text(
              _isLiked ? 'Unlike ($_likeCount)' : 'Like',
              style: TextStyle(
                color: _isLiked ? Colors.white : null,
              ),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              Get.to(() => DisasterDetails(disaster: widget.disaster));
            },
            style: TextButton.styleFrom(
              shape: const StadiumBorder(),
              minimumSize: const Size(150, 50),
              padding: const EdgeInsets.all(8),
              backgroundColor: Colors.transparent,
            ),
            child: const Text('Preview'),
          ),
        ],
      ),
    );
  }
}
