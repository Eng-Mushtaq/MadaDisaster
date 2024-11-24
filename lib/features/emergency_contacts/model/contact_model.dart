import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  String id;
  String emergencyServiceCategory;
  String departmentName;
  String contactNo;
  DateTime createdAt;

  ContactModel({
    required this.id,
    required this.emergencyServiceCategory,
    required this.departmentName,
    required this.contactNo,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  static ContactModel empty() => ContactModel(
        id: '',
        emergencyServiceCategory: '',
        departmentName: '',
        contactNo: '',
        createdAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() {
    return {
      'emergencyServiceCategory': emergencyServiceCategory,
      'departmentName': departmentName,
      'contactNo': contactNo,
      'createdAt': createdAt,
    };
  }

  factory ContactModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ContactModel.empty();
    final data = document.data()!;
    return ContactModel(
      id: document.id,
      emergencyServiceCategory: data['emergencyServiceCategory'] ?? '',
      departmentName: data['departmentName'] ?? '',
      contactNo: data['contactNo'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'Contact ID: $id, Category: $emergencyServiceCategory, Department: $departmentName, Contact No: $contactNo, Created At: $createdAt';
  }
}
