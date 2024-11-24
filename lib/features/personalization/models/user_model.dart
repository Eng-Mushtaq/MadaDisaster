import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

class UserModel {
  // Keep those values final which you do not want to update
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  // Constructor for UserModel.
  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNumber,
    required this.profilePicture,
  });

  // Helper function to get full name
  String get fullName => "$firstName $lastName";

  // Helper function to format to phone number
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  // Static function to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  // Static function to generate a username for the full name.
  static String generateUserName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName $lastName"; // Combine first and last name
    String usernameWithPrefix = camelCaseUsername; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  // static function to create an empty user model
  static UserModel empty() => UserModel(id: '', email: '', firstName: '', lastName: '', username: '', phoneNumber: '', profilePicture: '');

  // Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  // Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        email: data['Email'] ?? '',
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    }
    return UserModel.empty();
  }

  // Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromJson(Map<String, dynamic> document) {
    return UserModel(
      email: document['Email'] ?? '',
      firstName: document['FirstName'] ?? '',
      lastName: document['LastName'] ?? '',
      username: document['Username'] ?? '',
      phoneNumber: document['PhoneNumber'] ?? '',
      profilePicture: document['ProfilePicture'] ?? '',
      id: '',
    );
  }
}
