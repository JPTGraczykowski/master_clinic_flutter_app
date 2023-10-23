import 'package:master_clinic_flutter_app/models/cabinet.dart';
import 'package:master_clinic_flutter_app/models/specialty.dart';

enum UserRole {
  admin,
  doctor,
  patient,
}

class User {
  final String id;
  final UserRole role;
  final String email;
  final String firstName;
  final String lastName;
  final String telephone;
  final bool active;
  final String? specialtyId;
  final String? cabinetId;

  const User({
    required this.id,
    required this.role,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.telephone,
    required this.active,
    this.specialtyId,
    this.cabinetId,
  });

  String get fullName {
    return '$firstName $lastName';
  }
}
