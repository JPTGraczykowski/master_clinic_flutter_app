import './user.dart';

class Patient extends User {
  static const role = UserRole.patient;

  Patient({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.fullName,
    required super.telephone,
    required super.active,
  });
}
