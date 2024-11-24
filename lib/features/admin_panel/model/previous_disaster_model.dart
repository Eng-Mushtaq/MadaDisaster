import 'package:cloud_firestore/cloud_firestore.dart';

import '../../personalization/models/user_model.dart';

class PreviousDisasterModel {
  final String id;
  final String userId;
  final String disasterType;
  final String disasterProvince;
  final String disasterDistrict;
  final String disasterDescription;
  List<String>? disasterImageUrls;
  final PlaceLocation disasterLocation;
  final DateTime createdAt;
  UserModel? user;

  PreviousDisasterModel({
    required this.id,
    required this.userId,
    required this.disasterType,
    required this.disasterProvince,
    required this.disasterDistrict,
    required this.disasterDescription,
    required this.disasterImageUrls,
    required this.disasterLocation,
    DateTime? createdAt,
    this.user,
  }) : createdAt = createdAt ?? DateTime.now();

  static PreviousDisasterModel empty() => PreviousDisasterModel(
        id: '',
        disasterType: '',
        disasterProvince: '',
        disasterDistrict: '',
        disasterDescription: '',
        disasterImageUrls: [],
        disasterLocation: PlaceLocation(latitude: 0, longitude: 0, address: ''),
        userId: '',
        createdAt: DateTime.now(),
        user: UserModel.empty(),
      );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'disasterType': disasterType,
      'disasterProvince': disasterProvince,
      'disasterDistrict': disasterDistrict,
      'disasterDescription': disasterDescription,
      'disasterImageUrls': disasterImageUrls,
      'createdAt': createdAt,
      'disasterLocation': disasterLocation.toJson(),
      'user': user!.toJson(),
    };
  }

  factory PreviousDisasterModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return PreviousDisasterModel.empty();
    final data = document.data()!;

    return PreviousDisasterModel(
      id: document.id,
      disasterLocation: PlaceLocation.fromJson(data['disasterLocation']),
      userId: data['userId'] ?? '',
      disasterType: data['disasterType'] ?? '',
      disasterProvince: data['disasterProvince'] ?? '',
      disasterDistrict: data['disasterDistrict'] ?? '',
      disasterDescription: data['disasterDescription'] ?? '',
      disasterImageUrls: List<String>.from(data['disasterImageUrls'] ?? []),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      user: UserModel.fromSnapshot(data['user']),
    );
  }
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  factory PlaceLocation.fromJson(Map<String, dynamic> json) {
    return PlaceLocation(
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      address: json['address'] ?? '',
    );
  }
}
